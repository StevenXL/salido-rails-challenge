class Varietal < ActiveRecord::Base
  validates :name, presence: true
  validates :wine_type, presence: true

  belongs_to :wine_type
  has_many :wines
end
