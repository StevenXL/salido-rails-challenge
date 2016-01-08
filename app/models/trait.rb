class Trait < ActiveRecord::Base
  validates :name, presence: true

  has_many :wines, through: :winetrait
end
