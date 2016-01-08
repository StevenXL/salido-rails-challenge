class Wine < ActiveRecord::Base
  validates :name, presence: true
  validates :price_min, presence: true
  validates :price_max, presence: true
  validates :price_retail, presence: true

  has_many :winetraits, class_name: "WineTrait"
  has_many :traits, through: :winetraits
  belongs_to :appellation
  belongs_to :varietal
  belongs_to :vineyard
end
