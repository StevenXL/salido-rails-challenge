class WinesController < ApplicationController
  before_action :set_dependents, only: [:new, :create]

  def index
    @wines = Wine.all
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)

    if @wine.save
      redirect_to @wine
    else
      render :new
    end
  end

  private
  def set_dependents
    @varietals = Varietal.all
    @vineyards = Vineyard.all
    @appellations = Appellation.all
  end

  def wine_params
    params.require(:wine).permit(:name, :price_max, :price_retail, :price_min,
                                 :varietal_id, :vineyard_id, :appellation_id)
  end
end
