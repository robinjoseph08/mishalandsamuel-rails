class Guest < ActiveRecord::Base

  belongs_to :party
  belongs_to :meal

end