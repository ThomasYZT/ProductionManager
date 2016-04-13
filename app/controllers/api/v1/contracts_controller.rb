module Api module V1

    class ContractsController < ApiController
      skip_before_filter :restrict_access

      def create
        init_params = contract_params

        contract = Contract.new(init_params.reject { |k, v| k == 'party_a' || k == 'party_b'  })
        contract.contract_no = generate_contract_no('I-')

        if contract.signing(init_params)
          return render json: {code: 200, contract_no: contract.contract_no}
        end
        render json: {code: 404}
      end

      def modify_contract
        contract = Contract.find_by_contract_no(params[:contract_no])

        if contract
          if contract.modify(contract_params)
            return render json: {code: 200}
          end
          return render json: {code: 400}
        end
        render json: {code: 404, msg: "#{params[:contract_no]} not exist"}
      end

      # Transform initial contract to formal contract
      def signing_formal_contract
        initial_contract = Contract.find_by_contract_no(params[:contract_no])
        
        if initial_contract
          if initial_contract.transform(contract_params)
            return render json: {code: 200, 
                                 contract_no: 'F-' + initial_contract.contract_no.
                                 slice(2, initial_contract.contract_no.length - 1) }
          end
          return render json: {code: 400}
        end
        render json: {code: 404}
      end

      def destroy
        contract = Contract.find(params[:id])
        if contract.destroy
          return render json: { code: 200,
                                msg: "#{contract.contract_no} was delete" }
        end
        render json: { code: 400, msg: "#{contract.contract_no} delete faulted"}
      end

      def list_contracts
        if params[:contract_type] == 'initial'
          partten = 'I-'
        else
          partten = 'F-'
        end

        sql = "SELECT c.id, c.breed, c.contract_no, p.name, p.uuid, c.cultivated_area,
               c.purchase, c.updated_at,  u.username, u.phone
               FROM (contracts AS c LEFT JOIN users AS u ON u.id = c.user_id)
               LEFT JOIN party_bs AS p ON c.party_b_id = p.id
               WHERE c.contract_no LIKE '#{partten}%'
               AND u.station_id = #{params[:station_id]};"
        render json: Contract.find_by_sql(sql)
      end

      def show
        contract = Contract.find_by_contract_no(params[:contract_no])
        if contract
          return render json: { code: 200, 
                                contract: contract,
                                party_a: contract.party_a,
                                party_b: contract.party_b
                              }
        end

        render json: { code: 404, msg: "#{params[:contract_no]} not found"}
      end


      private
      def contract_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params[:contract][:user_id] = current_user.id
        json_params.require(:contract).permit(:breed, :cultivated_area,
                                             :transplant_number,
                                             :purchase, :user_id,
                                             :party_a => [:city, :company],
                                             :party_b => [
                                               :name, :phone, :card_number,
                                               :uuid, :address, :bank
                                             ])
      end

      def generate_contract_no(flag)
        created_at = Time.now.to_s
        flag + SecureRandom.hex(2) + created_at.slice(0, created_at.index('+')).gsub(/[^\d]/, '')
      end
    end

  end

end
