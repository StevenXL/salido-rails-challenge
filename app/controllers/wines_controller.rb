class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update]

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
      flash[:success] = "Wine successfully created."
      redirect_to @wine
    else
      flash[:danger] = "Wine not created."
      render :new
    end
  end

  def update
    if @wine.update_attributes(wine_params)
      flash[:success] = "Wine successfully updated."
      redirect_to @wine
    else
      flash[:danger] = "Wine was not updated."
      render :edit
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
