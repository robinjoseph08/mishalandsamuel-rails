class GuestSerializer < ActiveModel::Serializer

  attributes :id, :name, :email, :response, :party_id, :meal_id

end
