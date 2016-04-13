module Api
  module V1

    class AnalysisController < ApiController

      def contracts
        result = Contract.analysis(params[:station_id], 
                                   params[:start_time],
                                   params[:end_time])

        render json: {code: 200, 
                      formal_contracts:  deal_with_nil(result[0]),
                      initial_contracts: deal_with_nil(result[1])
                     }
      end

      private 
      def deal_with_nil(record)
        if record.nil?
          return {total: 0, purchase: 0, area: 0, transplant: 0}
        end
        record
      end

    end

  end
end
