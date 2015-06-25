class Party < ActiveRecord::Base

  before_create :generate_code
  after_save    :send_party_notification_email
  after_save    :send_guest_notification_email

  has_many :guests

  enum :label => [ :mathew, :johny ]

  def send_party_notification_email
    Mailer.notify_party_update(self).deliver_now if self.guests.count > 0
  end

  def send_guest_notification_email
    consolidated_guests.each do |guest|
      Mailer.guest_notification(guest, self).deliver_now
    end
  end

  def send_table_notification_email
    consolidated_guests.each do |guest|
      Mailer.table_notification(guest, self).deliver_now
    end
  end

  def address_line
    self.address1 + (self.address2.present? ? ", #{self.address2}" : "")
  end

  def city_state_zip_country
    "#{self.city}, #{self.state} #{self.zip}, #{self.country}"
  end

  def address
    "#{self.address_line}, #{self.city_state_zip_country}"
  end

  private

  def consolidated_guests
    guests = []
    self.guests.find_each do |guest|
      next if guest.not_attending? || guest.email.blank? # only deal with guests that are attending and have an email
      index = guests.index { |item| item[:email] == guest.email }
      if index.nil?
        g = {
          :name  => [guest.name],
          :email => guest.email
        }
        guests << g
      else
        guests[index][:name] << guest.name
      end
    end
    guests
  end

  def generate_code
    if self.code.blank?
      a    = ('A'..'Z').to_a+(0..9).to_a
      code = nil

      # exclusions for readability
      a.delete 0
      a.delete 'O'
      a.delete 1
      a.delete 'I'

      while code.nil? || Party.exists?(:code => code)
        code = (1..5).collect { a[rand(a.size)] }.join
      end

      self.code = code
    end
  end

end
