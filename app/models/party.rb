class Party < ActiveRecord::Base

  before_create :generate_code
  after_save    :send_notification_email

  has_many :guests

  enum :label => [ :mathew, :johny ]

  def send_notification_email
    Mailer.notify_party_update(self).deliver_now if self.guests.count > 0
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
