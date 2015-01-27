class Guest < ActiveRecord::Base

  belongs_to :party
  belongs_to :meal

  validates :meal, :presence => { :message => "can't be blank if you're attending" },    :if     => :attending
  validates :meal, :absence  => { :message => "must be blank if you're not attending" }, :unless => :attending

end