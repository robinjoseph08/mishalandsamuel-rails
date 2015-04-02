class Mailer < ActionMailer::Base

  default :from => "RSVP Notification <#{ENV['MAS_EMAIL_ADDRESS']}>"

  def notify_party_update party
    @party = party
    mail :to      => [ENV['ROBIN_EMAIL_ADDRESS'], ENV['MAS_EMAIL_ADDRESS'], ENV['DAD_EMAIL_ADDRESS']],
         :subject => "Party #{@party.id} Updated!"
  end

end
