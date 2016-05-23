class OffersController < ApplicationController

  def index
  end

  def search
    @offers = FyberService.new.offers(params[:user_id], params[:pub0], params[:page])

    puts @offers

    respond_to do |format|
      format.js
    end
  end
end
