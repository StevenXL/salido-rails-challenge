class WineSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_min, :price_max, :price_retail, :year
  has_many :traits
  has_one :appellation
  has_one :varietal
  has_one :vineyard

  def price_min
    object.price_min.to_f
  end

  def price_max
    object.price_max.to_f
  end

  def price_retail
    object.price_retail.to_f
  end
end
