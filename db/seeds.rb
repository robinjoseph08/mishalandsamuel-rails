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
