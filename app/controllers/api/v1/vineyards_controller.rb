class Api::V1::VineyardsController < Api::ApiController
  before_action :set_vineyard, except: [:index, :create]

  def index
    render status: 200, json: Vineyard.all
  end

  def show
    if @vineyard
      render status: 200, json: @vineyard
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Vineyard not found in database" }
    end
  end

  def create
    vineyard = Vineyard.find_or_initialize_by(vineyard_params)

    if vineyard.save
      render status: 200, json: vineyard
    else
      render status: 422, json: {
        status: "Unable to create vineyard",
        errors: vineyard.errors.full_messages
      }
    end
  end

  def update
    if @vineyard.update(vineyard_params)
      render status: 200, json: @vineyard
    else
      render status: 422, json: {
        status: "Unable to update vineyard",
        errors: vineyard.errors.full_messages
      }
    end
  end

  def destroy
    if @vineyard
      @vineyard.destroy
      render status: 200, json: {message: "Vineyard successfully deleted"}
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Vineyard not found in database" }
    end
  end

  private

  def set_vineyard
    @vineyard = Vineyard.find_by(id: params[:id])
  end

  def vineyard_params
    cleaned_input = params.require(:vineyard).permit(:name)
    titlecase_name_attr(cleaned_input)
  end

  def titlecase_name_attr(hash)
    hash.merge(name: hash[:name].titlecase)
  end
end
