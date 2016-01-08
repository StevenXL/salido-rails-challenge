class Varietal < ActiveRecord::Base
  validates :name, presence: true
  validates :winetype, presence: true

  belongs_to :winetype
  has_many :wines
end
