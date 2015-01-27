# Party

p      = Party.new
p.code = "TEST"
p.save!

# Guests

g       = Guest.new
g.name  = "Robin Joseph"
g.party = p
g.save!

g       = Guest.new
g.name  = "Mishal Mathew"
g.party = p
g.save!

g       = Guest.new
g.name  = "Samuel Johny"
g.party = p
g.save!
