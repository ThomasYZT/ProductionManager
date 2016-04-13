module Api
  module V1
    class ContractChangesController < ApiController

      def index
        station_id = 0
        if params[:station_id] && !params[:station_id].empty?
          station_id = params[:station_id]
        end

        if station_id.to_i > 0
          sql = "SELECT cc.* FROM contract_changes cc WHERE contract_id 
                 IN (SELECT c.id FROM contracts c WHERE c.user_id
                   IN (SELECT u.id FROM users u WHERE u.station_id = #{station_id})
                 ) ORDER BY cc.updated_at DESC;"

          result = ContractChange.find_by_sql(sql)
        else
          result = []
        end
        render json: { code: 200, result: result }
      end

    end
  end
end
