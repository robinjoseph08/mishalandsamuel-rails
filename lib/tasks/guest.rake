require 'csv'

namespace :guest do

  desc "Generate the CSV of guests"
  task :csv => [:environment] do
    file_name = "guests.csv"
    path      = File.expand_path("../../../data/#{file_name}", __FILE__)

    CSV.open(path, "w") do |csv|
      # header
      csv << ["ID", "Name", "Attending", "Meal", "Party ID", "Party Email"]

      Guest.order("id ASC").find_each do |g|
        data = []
        data << g.id
        data << g.name
        data << (g.party.email.blank? ? "Unknown" : g.attending)
        data << (g.meal ? g.meal.name : "N/A")
        data << g.party.id
        data << g.party.email

        csv << data
      end
    end
  end

end
