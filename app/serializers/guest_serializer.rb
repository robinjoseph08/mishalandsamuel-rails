class GuestSerializer < ActiveModel::Serializer

  attributes :id, :name, :coming, :party_id, :meal_id

end
