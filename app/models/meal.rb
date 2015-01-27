class Meal < ActiveRecord::Base

  has_many :guests

end