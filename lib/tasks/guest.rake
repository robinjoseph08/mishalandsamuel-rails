require 'csv'

namespace :guest do

  desc "Internal import from CSV"
  task :_import, [:label] => [:environment] do |t, args|
    path = File.expand_path("../../../data/#{args[:label]}.csv", __FILE__)

    num   = nil
    party = nil
    CSV.foreach path do |row|
      n = row.shift
      p = row.shift

      unless num == p
        num = p

        party       = Party.new
        party.label = args[:label]
        party.save!
        puts "=> Creating new party: #{party.id}"
      end

      g       = Guest.new
      g.name  = n
      g.party = party
      g.save!
      puts "  -> name: #{n}, party: #{p}"
    end
  end

  desc "Import from CSV"
  task :import, [:label] => [:environment] do |t, args|
    label = args[:label] || 'all'
    Rake::Task["guest:_import"].execute :label => 'mishal' if label == 'mishal' || label == 'all'
    Rake::Task["guest:_import"].execute :label => 'johny'  if label == 'johny'  || label == 'all'
  end

  desc "Generate the CSV of guests"
  task :export => [:environment] do
    file_name = "guests.csv"
    path      = File.expand_path("../../../data/#{file_name}", __FILE__)

    CSV.open(path, "w") do |csv|
      # header
      csv << ["ID", "Name", "Response", "Meal", "Party ID", "Party Email", "Party Code"]

      Guest.order("id ASC").find_each do |g|
        data = []
        data << g.id
        data << g.name
        data << g.response.titleize
        data << (g.meal ? g.meal.name : "N/A")
        data << g.party.id
        data << g.party.email
        data << g.party.code

        csv << data
      end
    end
  end

end
