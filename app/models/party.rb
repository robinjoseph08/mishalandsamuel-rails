class Party < ActiveRecord::Base

  has_many :guests

  validates :email,
            :presence => true,
            :format   => {
              :with    => /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/,
              :message => "isn't valid"
            },
            :on => :update

end