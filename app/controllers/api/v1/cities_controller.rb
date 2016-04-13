module Api
  module V1

    class CitiesController < ApiController

      def index
        #respond_with City.all
        render json: { code: 200, cities: City.all }
      end

      def list_companies
        respond_with Company.where('city_id = ?', params[:id])
      end

    end

  end
end
