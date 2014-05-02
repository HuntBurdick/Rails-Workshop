class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :body
      t.boolean :published, :boolean, :default => false
      t.integer :position
      t.timestamp :created_on
      t.timestamp :updated_on
    end
    Page.create :name => 'Home', :body => 'Welcome to CMS_Admin2', :position => 1
  end
end