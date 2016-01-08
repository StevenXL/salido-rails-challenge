class Vineyard < ActiveRecord::Base
  validates :name, presence: true

  has_many :wines
end
