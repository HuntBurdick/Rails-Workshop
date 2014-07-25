class PagesController < ApplicationController

  def index
    @page = Page.friendly.where(:position => 1)
  end

  def show
    @page = Page.friendly.find(params[:id])

    if @page.only_for_logged_in_members == false || @page.only_for_logged_in_members == true && user_signed_in?
      @posts = Post.where(:page_id => @page.id, :published => true).order("position ASC")
      send(@page.name.parameterize) rescue nil
    else
      flash[:alert] = "This page is private."
      redirect_to '/'
    end
  end

  private
    def home
      # Resources for page modules can be set here.
    end

end