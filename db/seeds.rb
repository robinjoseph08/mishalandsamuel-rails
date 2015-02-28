require "base64"

# Party

p       = Party.new
p.code  = "TEST"
p.label = :mathew
p.save!

# Guests

g       = Guest.new
g.name  = "Thomas Johnny"
g.party = p
g.save!

g       = Guest.new
g.name  = "Annie Johny"
g.party = p
g.save!

g       = Guest.new
g.name  = "Samuel Johny"
g.party = p
g.save!

# Photos

12.times do |i|
  p          = Photo.new
  p.data_url = "data:image/jpg;base64," + Base64.encode64(open("app/assets/images/gallery/#{i}.jpg") { |io| io.read }).gsub("\n", "")
  p.save
end