class AppellationsController < ApplicationController
  def index
    @appellations = Appellation.all
  end

  def new
    @appellation = Appellation.new
  end

  def create
    normalized_params = normalize(appellation_params)

    @appellation = Appellation.find_or_create_by(normalized_params)

    if @appellation.save
      flash[:success] = "Appellation successfully added to or found in database"
      redirect_to appellations_path
    else
      flash[:danger] = "Appellation was not created"
      render :new
    end
  end

  private

  def appellation_params
    params.require(:appellation).permit(:name, :region_id)
  end

  def normalize(hash)
    hash.each_with_object({}) do |(key, value), memo|
      memo[key] = value.titlecase
    end
  end
end
