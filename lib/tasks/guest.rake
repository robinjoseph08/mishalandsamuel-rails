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

  desc "Generate the CSV of guests"
  task :export => [:environment] do
    file_name = "guests.csv"
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

end
