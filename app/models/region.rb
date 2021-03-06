class Region < ActiveRecord::Base
  validates :name, presence: true

  has_many :appellations
  has_many :wines, through: :appellations
end
