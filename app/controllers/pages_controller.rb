class PagesController < ApplicationController 

  def index
    @page = Page.friendly.where(:position => 1)
  end

  def show
    @page = Page.friendly.find(params[:id])
    @posts = Post.where(:page_id => @page.id, :published => true).order("position ASC")

    send(@page.name.parameterize)
    # home

    respond_to do |format|
      format.html
    end
  end

  private
    def home
      # Resources for page modules can be set here.
      
    end

end