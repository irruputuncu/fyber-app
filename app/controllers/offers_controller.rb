class OffersController < ApplicationController

  def index
  end

  def search
    if params[:uid].blank?
      respond_to do |format|
        format.js {render 'failure'}
      end
      return
    end

    fyber_response = FyberService.new.get_offers(search_params)

    @offers = fyber_response['offers']
    @pages = fyber_response['pages']
    @page = params[:page].to_i || 1

    respond_to do |format|
      format.js
    end
  end

  private

    def search_params
      params.permit(:uid, :pub0, :page)
    end
end
