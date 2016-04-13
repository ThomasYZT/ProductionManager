module Api
  module V1

    class VersionsController < ApiController
      skip_before_filter :restrict_access

      def show
       # render json: Version.order('created_at').last
       #respond_with Version.order('created_at').last
        render json: {code: 200, version: Version.order('created_at').last }
      end

    end

  end
end
