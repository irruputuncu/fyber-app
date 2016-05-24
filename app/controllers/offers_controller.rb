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

    fyber_response = FyberService.new.offers(params[:user_id], params[:pub0], params[:page])
    @offers = fyber_response['offers']

    @page = params[:page]
    @pages = fyber_response['pages']

    respond_to do |format|
      format.js
    end
  end
end
