class ModuleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :module_child_name, :type => :string, :default => ''


  def copy_module_files

    route "namespace :admin do
      resources :#{parent_name} do
        collection do
          get 'move_up'
          get 'move_down'
          get 'publish'
          get 'destroy'
          get 'remove'
        end
      end
    end"

    create_file "db/migrate/#{Time.now.year}#{Time.now.to_i}_create_#{parent_name}.rb", <<-FILE
      class Create#{parent_controller_name} < ActiveRecord::Migration
        def change
          create_table :#{parent_name} do |t|
            t.string :slug
            t.string :name
            t.text :body
            t.attachment :image
            t.boolean :published, :boolean, :default => false
            t.integer :position
            t.timestamp :created_on
            t.timestamp :updated_on
          end
        end
      end
    FILE

  	# Model
    template "models/parent.erb", "app/models/#{parent_name.singularize}.rb"

    # Controller
    template "controllers/parent_controller.erb", "app/controllers/admin/#{parent_name}_controller.rb"

    directory "views/parent/", "app/views/admin/#{parent_name}/"

    template "ajax/parent_refresh.erb", "app/views/admin/#{parent_name}/list_refresh.js.erb"

    unless child_name == ''
    	# Model
	    template "models/child.erb", "app/models/#{child_name.singularize}.rb"
	    # Controller
	    template "controllers/child_controller.erb", "app/controllers/admin/#{child_name}_controller.rb"

      directory "views/child/", "app/views/admin/#{child_name}/"

      route "namespace :admin do
        resources :#{child_name} do
          collection do
            get 'move_up'
            get 'move_down'
            get 'new_post_for'
            get 'publish'
            get 'destroy'
            get 'remove'
          end
        end
      end"

      create_file "db/migrate/#{Time.now.year}#{Time.now.to_i}_create_#{child_name}.rb", <<-FILE
        class Create#{child_controller_name} < ActiveRecord::Migration
          def change
            create_table :#{child_name} do |t|
              t.string :title
              t.text :body
              t.attachment :image
              t.integer :page_id
              t.boolean :published
              t.integer :position
              t.string :meta_description
              t.attachment :image
            end
          end
        end
      FILE

      inject_into_file 'app/models/#{parent_name.singularize}.rb', after: "validates :name, :presence => true, :uniqueness => true\n" do <<-'RUBY'
        has_many :"#{child_name}", dependent: :destroy
      RUBY
      end

      inject_into_file 'app/models/#{parent_name.singularize}.rb', after: "friendly_id :name, use: :slugged\n" do <<-'RUBY'
        def self.child_items
          @child_items = .find(:all, :conditions => ["parent_id = ?", self.id])
          return @child_items
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
