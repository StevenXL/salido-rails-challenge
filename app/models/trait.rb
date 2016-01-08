class Trait < ActiveRecord::Base
  validates :name, presence: true

  has_many :winetraits, class_name: "WineTrait"
  has_many :wines, through: :winetraits
end
