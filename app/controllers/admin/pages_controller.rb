module Admin
  
  class PagesController < AdminController


    def index
      @pages = Page.paginate(:page => params[:page], :order => 'position ASC', :per_page => 10)
    end
    

    def new
      @page = Page.new
    end
    

    def edit
      @page = Page.find(params[:id])
    end
    

    def create
      @page = Page.new(page_params)
     
      if @page.save
        flash[:success] = "Page was created."
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
    end

  
    def update
      @page = Page.find(params[:id])

      respond_to do |format|
        if @page.update(page_params)
          format.html { redirect_to :back, :flash => { :success => 'Page was successfully updated.' } }
        else
          format.html { render action: 'edit' }
        end
      end
    end

    def publish
      page = Page.find(params[:page_id])
      page.published = ( page.published == true ? false : true)
      page.save

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def destroy
      page = Page.find(params[:page_id])
      page.destroy

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def move_up
      page = Page.find(params[:page_id])
      page.move_higher
      page.save

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def move_down
      page = Page.find(params[:page_id])
      page.move_lower
      page.save

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    private

      def list_refresh
        @pages = Page.paginate(:page => params[:page], :order => 'position ASC', :per_page => 10)
        return render(:file => 'admin/pages/list_refresh.js.erb')
      end

      def page_params
        params.require(:page).permit( :name, :body, :published, :position, :created_on, :updated_on)
      end
    
  end

end
