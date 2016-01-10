class VarietalsController < ApplicationController
  def index
    @varietals = Varietal.all
  end

  def new
    @varietal = Varietal.new
  end

  def create
    normalized_params = normalize(varietal_params)

    @varietal = Varietal.find_or_create_by(normalized_params)

    if @varietal.save
      flash[:success] = "Varietal successfully added to or found in database"
      redirect_to varietals_path
    else
      flash[:danger] = "varietal not saved"
      render :new
    end
  end

  private

  def varietal_params
    params.require(:varietal).permit(:name,:wine_type_id)
  end

  def normalize(hash)
    hash.each_with_object({}) do |(key, value), memo|
      memo[key] = value.titlecase
    end
  end
end
