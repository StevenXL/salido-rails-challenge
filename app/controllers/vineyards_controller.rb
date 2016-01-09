class VineyardsController < ApplicationController
  def index
    @vineyards = Vineyard.all
  end

  def new
    @vineyard = Vineyard.new
  end

  def create
    normalized_params = normalize(vineyard_params)
    @vineyard = Vineyard.find_or_create_by(normalized_params)

    if @vineyard.save
      flash[:success] = "Vineyard successfully added to or found in database"
      redirect_to vineyards_path
    else
      flash[:danger] = "Vineyard not successfully saved"
      render :new
    end
  end

  private

  def vineyard_params
    params.require(:vineyard).permit(:name)
  end

  def normalize(hash)
    hash.each_with_object({}) do |(key, value), memo|
      memo[key] = value.titlecase
    end
  end
end
