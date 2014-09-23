class PagesController < ApplicationController

  def index
    @page = Page.friendly.where(:position => 1)
  end

  def show
    set_page
    
    @page_title       = label_for_string(@page.name)
    @page_description = @page.body.blank? ? '' : @page.body.truncate(60)

    if @page.only_for_logged_in_members == false || @page.only_for_logged_in_members == true && user_signed_in?
      @posts = Post.where(:page_id => @page.id, :published => true).order("position ASC")
      send(@page.name.parameterize) rescue nil
    else
      flash[:alert] = "This page is private."
      redirect_to '/'
    end
  end

  private
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    def home
      set_page
      # Resources for page modules can be set here.
    end

end