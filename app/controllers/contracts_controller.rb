class ContractsController < ApplicationController
  def index
  	@contracts = Contract.all
  	respond_to do |format|
      format.html
      format.json { render json:@contracts}
  	end
  end
end
