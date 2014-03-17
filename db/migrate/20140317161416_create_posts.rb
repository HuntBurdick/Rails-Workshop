class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :page_id
      t.boolean :published
      t.string :meta_description
      t.attachment :image

      t.timestamps
    end
  end
end
