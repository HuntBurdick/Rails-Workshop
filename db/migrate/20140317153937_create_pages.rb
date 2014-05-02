class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.column "name", :string
      t.column "body", :text
      t.column "published", :boolean, :default => "0"
      t.column "position", :integer
      t.column "created_on", :timestamp
      t.column "updated_on", :timestamp
    end
    Page.create :name => 'Home', :body => 'Welcome to CMS_Admin2', :position => 1
  end
end