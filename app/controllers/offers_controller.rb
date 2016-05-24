class OffersController < ApplicationController

  def index
  end

  def search
    if params[:user_id].blank?
      respond_to do |format|
        format.js {render 'failure'}
      end
      return
    end

    @offers = FyberService.new.offers(params[:user_id], params[:pub0], params[:page])

    respond_to do |format|
      format.js
    end
  end
end
