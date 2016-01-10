class Api::V1::AppellationsController < Api::ApiController
  before_action :set_appellation, except: [:index, :create]

  def index
    render status: 200, json: Appellation.all
  end

  def show
    if @appellation
      render status: 200, json: @appellation
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Appellation not found in database" }
    end
  end

  def create
    appellation = Appellation.find_or_initialize_by(appellation_params)

    if appellation.save
      render status: 200, json: appellation
    else
      render status: 422, json: {
        status: "Unable to create appellation",
        errors: appellation.errors.full_messages
      }
    end
  end

  def update
    if @appellation.update(appellation_params)
      render status: 200, json: @appellation
    else
      render status: 422, json: {
        status: "Unable to update appellation",
        errors: appellation.errors.full_messages
      }
    end
  end

  def destroy
    if @appellation
      @appellation.destroy
      render status: 200, json: {message: "Appellation successfully deleted"}
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Wine not found in database" }
    end
  end

  private

  def set_appellation
    @appellation = Appellation.find_by(id: params[:id])
  end

  def appellation_params
    cleaned_input = params.require(:appellation).permit(:name, :region_id)
    titlecase_name_attr(cleaned_input)
  end

  def titlecase_name_attr(hash)
    hash.merge(name: hash[:name].titlecase)
  end
end
