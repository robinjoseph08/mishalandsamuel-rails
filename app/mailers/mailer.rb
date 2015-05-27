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

  def send_csv path
    attachments['master.csv'] = File.read path
    mail :to      => [ENV['ROBIN_EMAIL_ADDRESS'], ENV['MAS_EMAIL_ADDRESS'], ENV['DAD_EMAIL_ADDRESS']],
         :from    => "Wedding Updates <#{ENV['MAS_EMAIL_ADDRESS']}>",
         :subject => "Updated Master CSV"
  end

  def send_invite email, party
    @code = party.code
    mail :to      => email,
         :from    => "Mishal and Samuel <#{ENV['MAS_EMAIL_ADDRESS']}>",
         :subject => "Mathew/Johny Wedding Invitation"
  end

end
