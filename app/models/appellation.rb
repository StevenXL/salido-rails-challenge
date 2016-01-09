class Appellation < ActiveRecord::Base
  validates :name, presence: true
  validates :region, presence: true

  belongs_to :region
  has_many :wines
end
