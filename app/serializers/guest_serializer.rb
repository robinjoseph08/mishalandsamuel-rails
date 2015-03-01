class GuestSerializer < ActiveModel::Serializer

  attributes :id, :name, :response, :party_id, :meal_id

end
