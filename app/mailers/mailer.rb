class Mailer < ActionMailer::Base

  def notify_party_update party
    @party = party
    mail :to      => [ENV['ROBIN_EMAIL_ADDRESS'], ENV['MAS_EMAIL_ADDRESS'], ENV['DAD_EMAIL_ADDRESS']],
         :from    => "RSVP Notification <#{ENV['MAS_EMAIL_ADDRESS']}>",
         :subject => "Party #{@party.id} Updated!"
  end

  def guest_notification guest, party
    @guest = guest
    @party = party
    mail :to      => @guest[:email],
         :from    => "Mishal and Samuel <#{ENV['MAS_EMAIL_ADDRESS']}>",
         :subject => "Thanks for your RSVP!"
  end

end
