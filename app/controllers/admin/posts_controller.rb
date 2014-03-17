module Admin
  
  class PostsController < AdminController
    
    def index
      @posts = Post.find(:all)
    end
    

    def new
      @post = Post.new
    end
    

    def edit
      @post = Post.find(params[:id])
    end
    

    def create
      @posts = Post.new(page_params)
     
      if @posts.save
        flash[:success] = "Page was created."
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
    end

  
    def update
      @posts = Post.find(params[:id])

      respond_to do |format|
        if @posts.update(page_params)
          format.html { redirect_to :back, :flash => { :success => 'Page was successfully updated.' } }
        else
          format.html { render action: 'edit' }
        end
      end
    end

    private

      def page_params
        params.require(:post).permit( :title, :body, :page_id, :published, :meta_description, :image, :created_on, :updated_on)
      end

  end

end
