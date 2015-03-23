class Party < ActiveRecord::Base

  before_create :generate_code
  after_save    :send_notification_email

  has_many :guests

  validates :email,
            :format => {
              :with    => /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/,
              :message => "isn't valid"
            },
            :unless => "email.blank?"

  enum :label => [ :mathew, :johny ]

  def send_notification_email
    Mailer.notify_party_update(self).deliver_now if self.guests.count > 0
  end

  private

  def generate_code
    if self.code.blank?
      a    = ('A'..'Z').to_a+(0..9).to_a
      code = nil
      a.delete 'I'

      while code.nil? || Party.exists?(:code => code)
        code = (1..5).collect { a[rand(a.size)] }.join
      end

      self.code = code
    end
  end

end
