module Admin
  
  class PagesController < AdminController


    def index
      @pages = Page.find(:all)
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

    private

      def page_params
        params.require(:page).permit( :name, :body, :published, :position, :created_on, :updated_on)
      end
    
  end

end
