class PartyBsController < ApplicationController
  def index
  	@party_bs = PartyB.all
  	respond_to do |format|
      format.html
      format.json { render json:@party_bs}
  	end
  end
end
