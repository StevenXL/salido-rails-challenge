class Region < ActiveRecord::Base
  validates :name, presence: true

  has_many :appellations
end
