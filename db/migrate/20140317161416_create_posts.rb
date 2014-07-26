class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.attachment :image
      t.integer :page_id
      t.boolean :published
      t.integer :position
      t.string :meta_description
      t.attachment :image

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
