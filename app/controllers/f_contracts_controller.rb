class FContractsController < ApplicationController
  def index
  	@contracts = Contract.where(user_id:session[:userid]).where.not(initial_id: nil)
  	@party_as = PartyA.joins("INNER JOIN contracts ON contracts.initial_id IS NOT NULL AND party_as.id = contracts.party_a_id")
  	@party_bs = PartyB.joins("INNER JOIN contracts ON contracts.initial_id IS NOT NULL AND party_bs.id = contracts.party_b_id")
  	
  	respond_to do |format|
      format.html
      format.json { render json:{contracts:@contracts,party_as:@party_as,party_bs:@party_bs}}
  	end
  end

end
