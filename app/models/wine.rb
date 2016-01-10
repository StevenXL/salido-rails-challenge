class Wine < ActiveRecord::Base
  validates :name, presence: true
  validates :price_min, presence: true
  validates :price_max, presence: true
  validates :price_retail, presence: true

  has_many :winetraits, class_name: "WineTrait", dependent: :destroy
  has_many :traits, through: :winetraits
  belongs_to :appellation
  belongs_to :varietal
  belongs_to :vineyard

  def as_json(options = {})
    super(except: [:created_at,
                   :updated_at,
                   :varietal_id,
                   :vineyard_id,
                   :appellation_id],
          include: [:varietal,
                    :vineyard,
                    :appellation,
                    :traits])
  end
end
