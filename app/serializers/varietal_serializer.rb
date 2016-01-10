class VarietalSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :wine_type
end
