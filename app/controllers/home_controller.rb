class HomeController < ApplicationController
  def index
    page = page_params[:page]
    @photos = Photo.page(page)
  end

  private

  def page_params
    params.permit(:page)
  end
end
