class PagesController < ApplicationController 

  def index
    @page = Page.friendly.where(:position => 1)
  end

  def show
    @page = Page.friendly.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

end