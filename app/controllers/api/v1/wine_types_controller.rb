class Api::V1::WineTypesController < Api::ApiController
  before_action :set_wine_type, except: [:index, :create]

  def index
    render status: 200, json: WineType.all
  end

  def show
    if @wine_type
      render status: 200, json: @wine_type
    else
      render status: 404, json: {status: "Not Found",
                                 message: "WineType not found in database" }
    end
  end

  def create
    wine_type = WineType.find_or_initialize_by(wine_type_params)

    if wine_type.save
      render status: 200, json: wine_type
    else
      render status: 422, json: {
        status: "Unable to create wine type",
        errors: wine_type.errors.full_messages
      }
    end
  end

  def update
    if @wine_type.update(wine_type_params)
      render status: 200, json: @wine_type
    else
      render status: 422, json: {
        status: "Unable to update wine type",
        errors: wine_type.errors.full_messages
      }
    end
  end

  def destroy
    if @wine_type
      @wine_type.destroy
      render status: 200, json: {message: "Wine type successfully deleted"}
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Wine type not found in database" }
    end
  end

  private

  def set_wine_type
    @wine_type = WineType.find_by(id: params[:id])
  end

  def wine_type_params
    cleaned_input = params.require(:wine_type).permit(:name)
    titlecase_name_attr(cleaned_input)
  end

  def titlecase_name_attr(hash)
    hash.merge(name: hash[:name].titlecase)
  end
end
