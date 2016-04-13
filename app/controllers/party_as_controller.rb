class PartyAsController < ApplicationController
  def index
  	@party_as = PartyA.all
  	respond_to do |format|
      format.html
      format.json { render json:@party_as}
  	end
  end
end
