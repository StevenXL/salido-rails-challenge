class Wine < ActiveRecord::Base
  validates :name, presence: true
  validates :price_min, presence: true
  validates :price_max, presence: true
  validates :price_retail, presence: true
  validates :year, presence: true

  has_many :traits, through: :winetrait
  belongs_to :appellation
  belongs_to :varietal
  belongs_to :vineyard
end
