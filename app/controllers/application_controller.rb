class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : "application"
    # or turn layout off for every devise controller:
    devise_controller? && "application"
  end

  def after_sign_in_path_for(resource)
	  '/admin'
	end

	def after_sign_out_path_for(resource)
		'/admin'
	end

end