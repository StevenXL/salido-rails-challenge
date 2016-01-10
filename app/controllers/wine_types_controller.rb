class WineTypesController < ApplicationController
  def index
    @wine_types = WineType.all
  end

  def new
    @wine_type = WineType.new
  end

  def create
    normalized_params = normalize(region_params)

    @wine_type = WineType.find_or_create_by(normalized_params)

    if @wine_type.save
      flash[:success] = "Wine Type successfully added to or found in database"
      redirect_to wine_types_path
    else
      flash[:danger] = "Wine Type not saved"
      render :new
    end
  end

  private

  def region_params
    params.require(:wine_type).permit(:name)
  end

  def normalize(hash)
    hash.each_with_object({}) do |(key, value), memo|
      memo[key] = value.titlecase
    end
  end
end
