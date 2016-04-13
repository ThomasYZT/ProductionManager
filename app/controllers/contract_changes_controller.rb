class ContractChangesController < ApplicationController
  def index
  	@contract_changes = ContractChange.all
  	respond_to do |format|
      format.html
      format.json { render json:@contract_changes}
  	end
  end
end
