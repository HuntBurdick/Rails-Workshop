class ModuleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :module_child_name, :type => :string, :default => ''


  def copy_module_files

  	# Model
    template "models/module.erb", "app/models/#{parent_name.singularize}.rb"
    # Controller
    template "controllers/module_controller.erb", "app/controllers/#{parent_name}_controller.rb"

    directory "views/parent/", "app/views/admin/#{parent_name}/"

    inject_into_file 'config/routes.rb', after: "namespace :admin do\n" do <<-'RUBY'
		  resources :pages do
	      collection do
	        get 'move_up'
	        get 'move_down'
	        get 'publish'
	        get 'destroy'
	        get 'remove'
	      end
	    end
		RUBY
		end

    unless child_name == ''
    	# Model
	    template "models/module.erb", "app/models/#{parent_name.singularize}.rb"
	    # Controller
	    template "controllers/module_controller.erb", "app/controllers/#{parent_name}_controller.rb"

      directory "views/child/", "app/views/admin/#{child_name}/"

      inject_into_file 'config/routes.rb', after: "namespace :admin do\n" do <<-'RUBY'
			  resources :posts do
		      collection do
		        get 'move_up'
		        get 'move_down'
		        get 'new_child_for'
		        get 'publish'
		        get 'destroy'
		        get 'remove'
		      end
		    end
			RUBY
			end
    end

  end

  private
  	def parent_name
  		file_name.underscore
  	end

    def parent_model_name
      file_name.singularize.camelize
    end

    def parent_controller_name
      file_name.camelize
    end



  	def child_name
  		module_child_name.underscore
  	end

    def child_model_name
      module_child_name.singularize.camelize
    end

    def child_controller_name
      module_child_name.camelize
    end
end
