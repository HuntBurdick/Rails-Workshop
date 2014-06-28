module Admin
  
  class PostsController < AdminController
    
    def index
      @pages = Page.paginate(:page => params[:page], :order => 'name ASC', :per_page => 10)
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
        flash[:success] = "Post was created."
        redirect_to :action => 'index'
      else
        render :action => 'new'
      end
    end

  
    def update
      @posts = Post.find(params[:id])

      if @posts.update(page_params)
        flash[:notice] = 'Post was successfully updated.'
        redirect_to :back
      else
        render action: 'edit'
      end
    end

    def publish
      post = Post.find(params[:post_id])
      post.published = ( post.published == true ? false : true)
      post.save

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def destroy
      post = Post.find(params[:post_id])
      post.destroy

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def move_up
      post = Post.find(params[:post_id])
      post.move_higher
      post.save

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def move_down
      post = Post.find(params[:post_id])
      post.move_lower
      post.save

      respond_to do |format|
        # format.html 
        format.js { list_refresh }
      end
    end

    def new_post_for
      post = Post.new(:page_id => params[:page_id])
      post.save
      redirect_to :action => 'edit', :id => post
    end

    private

      def list_refresh
        @pages = Page.paginate(:page => params[:page], :order => 'Name ASC', :per_page => 10)
        return render(:file => 'admin/posts/list_refresh.js.erb')
      end

      def page_params
        params.require(:post).permit( :title, :body, :page_id, :published, :meta_description, :image, :created_on, :updated_on)
      end

  end

end
