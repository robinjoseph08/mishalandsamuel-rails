class PartySerializer < ActiveModel::Serializer

  attributes :id, :code, :email, :guest_ids

end
