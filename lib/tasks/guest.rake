require 'csv'

namespace :guest do

  desc "Internal import from CSV"
  task :_import, [:label] => [:environment] do |t, args|
    path = File.expand_path("../../../data/#{args[:label]}.csv", __FILE__)

    num   = nil
    party = nil
    CSV.foreach path do |row|
      name      = row.shift.try(:strip)
      party_num = row.shift.try(:strip)
      code      = row.shift.try(:strip)
      address1  = row.shift.try(:strip)
      address2  = row.shift.try(:strip)
      cszc      = row.shift.try(:strip).split(', ') rescue []
      city      = cszc.shift.try(:strip)
      sz        = cszc.shift.try(:strip).split(' ') rescue []
      state     = sz.shift.try(:strip)
      zip       = sz.empty? ? nil : sz.join(' ')
      country   = cszc.shift.try(:strip) || (city.blank? ? nil : 'US')
      email     = row.shift.try(:strip).try(:downcase)

      unless num == party_num
        num = party_num

        party          = Party.new
        party.label    = args[:label]
        party.code     = code if code.present?
        party.address1 = address1
        party.address2 = address2
        party.city     = city
        party.state    = state
        party.zip      = zip
        party.country  = country
        party.save!
        puts "=> Creating new party: #{party.id}" + (address1.present? ? ", address: #{party.address}" : "") + (code.present? ? ", code: #{party.code}" : "")
      end

      g       = Guest.new
      g.name  = name
      g.email = email
      g.party = party
      g.save!
      puts "  -> name: #{name}, party: #{party.id}" + (email.present? ? ", email: #{email}" : "")
    end
  end

  desc "Import from CSV"
  task :import, [:label] => [:environment] do |t, args|
    label = args[:label] || 'all'
    Rake::Task["guest:_import"].execute :label => 'mathew' if label == 'mathew' || label == 'all'
    Rake::Task["guest:_import"].execute :label => 'johny'  if label == 'johny'  || label == 'all'
  end

  desc "Import table numbers from CSV"
  task :seating => [:environment] do |t, args|
    path = File.expand_path("../../../data/seating.csv", __FILE__)

    CSV.foreach path do |row|
      id    = row.shift.try(:strip).try(:to_i)
      name  = row.shift.try(:strip)
      table = row.shift.try(:strip).try(:to_i)

      if id
        g = Guest.find id
        if g.attending?
          if table.nil?
            puts "Blank table for attending guest: #{id}, #{name}, #{table}"
          else
            g.table_number = table
            g.save
          end
        else
          unless table.nil?
            puts "Table assigned for not attending guest: #{id}, #{name}, #{table}"
          end
        end
      else
        puts "Unparsable id: #{id}, #{name}, #{table}"
      end
    end
  end

  desc "Generate the CSV of guests"
  task :export => [:environment] do
    file_name = "master.csv"
    path      = File.expand_path("../../../data/#{file_name}", __FILE__)

    CSV.open(path, "w") do |csv|
      # header
      csv << ["ID", "Name", "Email", "Response", "Meal", "Party ID", "Party Code", "Party Address 1", "Party Address 2", "Party City", "Party State", "Party Zip", "Party Country", "Label"]

      Guest.order("id ASC").find_each do |g|
        data = []
        data << g.id
        data << g.name
        data << g.email
        data << g.response.titleize
        data << (g.meal ? g.meal.name : "N/A")
        data << g.party.id
        data << g.party.code
        data << g.party.address1
        data << g.party.address2
        data << g.party.city
        data << g.party.state
        data << g.party.zip
        data << g.party.country
        data << g.party.label.titleize

        csv << data
      end
    end
  end

  desc "List guests alphabetically"
  task :list => [:environment] do
    print_city = false
    next_print_city = false
    letter = "A"
    puts letter
    guests = Guest.where(:response => 1).order("name ASC")
    guests.each_with_index do |g, i|
      next unless g.attending?
      if g.name.first != letter
        letter = g.name.first
        puts letter
      end
      str = g.name
      if guests[i + 1] && g.name == guests[i + 1].name
        print_city = true
        next_print_city = true
      else
        next_print_city = false
      end
      if print_city && !g.party.city.nil?
        str += " (#{g.party.city})"
      end
      str += " - Table #{g.table_number}"
      puts str
      print_city = next_print_city
    end
  end

  desc "Generate the mailing CSV"
  task :mailing => [:environment] do
    file_name = "mailing.csv"
    path      = File.expand_path("../../../data/#{file_name}", __FILE__)

    CSV.open(path, "w") do |csv|
      # header
      csv << ["Party ID", "Party Name", "Address 1", "Address 2", "Label"]

      Party.order("id ASC").find_each do |p|
        data = []
        guests = p.guests.order("id ASC")
        data << p.id
        data << guests.first.name + (guests.count > 1 ? " & Family" : "")
        data << (p.address1.present? ? p.address1 + (p.address2.present? ? ", #{p.address2}" : "") : "N/A")
        data << (p.address1.present? ? "#{p.city}, #{p.state} #{p.zip}" + (p.country == "US" ? "" : ", #{p.country}") : "N/A")
        data << p.label.titleize

        csv << data
      end
    end
  end

  desc "Send email with CSV"
  task :email => [:environment, :export] do
    puts "Sending email..."
    file_name = "master.csv"
    path      = File.expand_path("../../../data/#{file_name}", __FILE__)
    Mailer.send_csv(path).deliver_now
  end

  desc "Send table number notification email"
  task :table_number_email => [:environment] do
    Party.order("id ASC").all.each do |p|
      puts "Sending email to party #{p.id}..."
      p.send_table_notification_email
    end
  end

end
