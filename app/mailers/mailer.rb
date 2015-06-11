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
    @data = {}
    @data[:unconfirmed] = {
      :total => Guest.where(:response => 0).count,
      :mathew => Guest.joins(:party).where(:response => 0, :parties => { :label => 0 }).count,
      :johny => Guest.joins(:party).where(:response => 0, :parties => { :label => 1 }).count
    }
    @data[:rsvp] = {
      :total => Guest.all.count - @data[:unconfirmed][:total],
      :mathew => Guest.joins(:party).where(:parties => { :label => 0 }).count - @data[:unconfirmed][:mathew],
      :johny => Guest.joins(:party).where(:parties => { :label => 1 }).count - @data[:unconfirmed][:johny]
    }
    @data[:not_attending] = {
      :total => Guest.where(:response => 2).count,
      :mathew => Guest.joins(:party).where(:response => 2, :parties => { :label => 0 }).count,
      :johny => Guest.joins(:party).where(:response => 2, :parties => { :label => 1 }).count
    }
    @data[:attending] = {
      :total => Guest.where(:response => 1).count,
      :mathew => Guest.joins(:party).where(:response => 1, :parties => { :label => 0 }).count,
      :johny => Guest.joins(:party).where(:response => 1, :parties => { :label => 1 }).count
    }

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
