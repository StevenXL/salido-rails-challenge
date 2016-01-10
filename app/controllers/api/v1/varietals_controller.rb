class Api::V1::VarietalsController < Api::ApiController
  before_action :set_varietal, except: [:index, :create]

  def index
    render status: 200, json: Varietal.all
  end

  def show
    if @varietal
      render status: 200, json: @varietal
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Varietal not found in database" }
    end
  end

  def create
    varietal = Varietal.find_or_initialize_by(varietal_params)

    if varietal.save
      render status: 200, json: varietal
    else
      render status: 422, json: {
        status: "Unable to create varietal",
        errors: varietal.errors.full_messages
      }
    end
  end

  def update
    if @varietal.update(varietal_params)
      render status: 200, json: @varietal
    else
      render status: 422, json: {
        status: "Unable to update varietal",
        errors: varietal.errors.full_messages
      }
    end
  end

  def destroy
    if @varietal
      @varietal.destroy
      render status: 200, json: {message: "Varietal successfully deleted"}
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Varietal not found in database" }
    end
  end

  private

  def set_varietal
    @varietal = Varietal.find_by(id: params[:id])
  end

  def varietal_params
    cleaned_input = params.require(:varietal).permit(:name, :wine_type_id)
    titlecase_name_attr(cleaned_input)
  end

  def titlecase_name_attr(hash)
    hash.merge(name: hash[:name].titlecase)
  end
end
