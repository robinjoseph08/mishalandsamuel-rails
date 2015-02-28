class GuestSerializer < ActiveModel::Serializer

  attributes :id, :name, :response, :under_2_years, :party_id, :meal_id

end
