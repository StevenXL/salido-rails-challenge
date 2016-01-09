class RegionsController < ApplicationController
  def index
    @regions = Region.all
  end

  def new
    @region = Region.new
  end

  def create
    normalized_params = normalize(region_params)

    @region = Region.find_or_create_by(normalized_params)

    if @region.save
      flash[:success] = "Region successfully added to or found in database"
      redirect_to regions_path
    else
      flash[:danger] = "Region not saved"
      render :new
    end
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end

  def normalize(hash)
    hash.each_with_object({}) do |(key, value), memo|
      memo[key] = value.titlecase
    end
  end
end
