class Api::V1::RegionsController < Api::ApiController
  before_action :set_region, except: [:index, :create]

  def index
    render status: 200, json: Region.all
  end

  def show
    if @region
      render status: 200, json: @region
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Region not found in database" }
    end
  end

  def create
    region = Region.find_or_initialize_by(region_params)

    if region.save
      render status: 200, json: region
    else
      render status: 422, json: {
        status: "Unable to create region",
        errors: region.errors.full_messages
      }
    end
  end

  def update
    if @region.update(region_params)
      render status: 200, json: @region
    else
      render status: 422, json: {
        status: "Unable to update region",
        errors: region.errors.full_messages
      }
    end
  end

  def destroy
    if @region
      @region.destroy
      render status: 200, json: {message: "Region successfully deleted"}
    else
      render status: 404, json: {status: "Not Found",
                                 message: "Region not found in database" }
    end
  end

  private

  def set_region
    @region = Region.find_by(id: params[:id])
  end

  def region_params
    cleaned_input = params.require(:region).permit(:name)
    titlecase_name_attr(cleaned_input)
  end

  def titlecase_name_attr(hash)
    hash.merge(name: hash[:name].titlecase)
  end
end
