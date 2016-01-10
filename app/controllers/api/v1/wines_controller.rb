class Api::V1::WinesController < Api::ApiController
  before_action :set_wine, except: [:index, :create]

  def index
    render status: 200, json: Wine.all
  end

  def show
    if @wine
      render status: 200, json: @wine
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Wine not found in database" }
    end
  end

  def create
    wine = Wine.find_or_initialize_by(wine_params)

    if wine.save
      render status: 200, json: wine
    else
      render status: 422, json: {
        status: "Unable to create wine",
        errors: wine.errors.full_messages
      }
    end
  end

  def update
    if @wine.update(wine_params)
      render status: 200, json: @wine
    else
      render status: 422, json: {
        status: "Unable to update wine",
        errors: wine.errors.full_messages
      }
    end
  end

  def destroy
    if @wine
      @wine.destroy

      render status: 200, json: {message: "Wine successfully deleted"}
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Wine not found in database" }
    end
  end

  private

  def set_wine
    @wine = Wine.find_by(id: params[:id])
  end

  def wine_params
    cleaned_input = params.require(:wine).permit(:name, :price_min, :price_max,
                                                 :price_retail, :year,
                                                 :varietal_id,
                                                 :vineyard_id,:appellation_id)

    titlecase_name_attr(cleaned_input)
  end

  def titlecase_name_attr(hash)
    hash.merge(name: hash[:name].titlecase)
  end
end
