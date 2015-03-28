class Guest < ActiveRecord::Base

  belongs_to :party
  belongs_to :meal

  validates :response, :inclusion => { :in   => ["attending", "not_attending"],               :message => "must be filled out" }, :on => :update
  validates :email,    :format    => { :with => /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/, :message => "isn't valid" },        :unless => "email.blank?"

  validates :meal,     :presence  => { :message => "can't be blank if you're attending" },    :if     => "attending?"
  validates :meal,     :absence   => { :message => "must be blank if you're not attending" }, :unless => "attending?"

  enum :response => [ :unconfirmed, :attending, :not_attending ]

end
