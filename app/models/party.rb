class Party < ActiveRecord::Base

  after_save :send_notification_email

  has_many :guests

  validates :email,
            :format   => {
              :with    => /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/,
              :message => "isn't valid"
            },
            :unless => "email.blank?"

  enum :label => [ :mathew, :johny ]

  def send_notification_email
    Mailer.notify_party_update(self).deliver_now
  end

end