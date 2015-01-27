class GuestSerializer < ActiveModel::Serializer

  attributes :id, :name, :attending, :party_id, :meal_id

end
