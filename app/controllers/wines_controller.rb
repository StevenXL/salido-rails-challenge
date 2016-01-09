class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit]

  def index
    @wines = Wine.all
  end

  def show
  end

  def edit
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

  def set_wine
    @wine = Wine.find_by(id: params[:id])
  end

  def wine_params
    params.require(:wine).permit(:name, :price_max, :price_retail, :price_min,
                                 :varietal_id, :vineyard_id, :appellation_id)
  end
end
