module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token

    def default_serializer_options
      {root: false}
    end
  end
end
