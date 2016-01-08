class WineTrait < ActiveRecord::Base
  validates :wine, presence: true
  validates :trait, presence: true

  belongs_to :wine
  belongs_to :trait
end
