class DashboardController < ApplicationController
  def index
  	@contracts = Contract.where(user_id:session[:userid])
  	respond_to do |format|
      format.html
      format.json { render json:@contracts}
  	end
  end
end
