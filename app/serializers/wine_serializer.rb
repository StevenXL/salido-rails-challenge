class WineSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_min, :price_max, :price_retail, :year
  has_many :traits
  has_one :appellation
  has_one :varietal
  has_one :vineyard
end
