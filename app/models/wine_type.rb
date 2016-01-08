class WineType < ActiveRecord::Base
  validates :name, presence: true

  has_many :varietals
end
