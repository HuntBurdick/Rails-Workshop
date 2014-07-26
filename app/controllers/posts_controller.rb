class PostsController < ApplicationController
	def show
		@post = Post.friendly.find(params[:id])
		@page_title       = label_for_string(@post.title)
    @page_description = @post.body.blank? ? '' : @post.body.truncate(60)
	end
end
