class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :menu_pages

  def menu_pages
		@pages = Page.where(:published => true).order('position ASC')
	end

  def after_sign_in_path_for(resource)
	  '/admin'
	end

	def after_sign_out_path_for(resource)
		'/admin'
	end

end