class Post < ActiveRecord::Base
	acts_as_list
	belongs_to :page

	has_attached_file :image, :styles => { :large => "800x800>", :medium => "250x250#", :thumb => "150x150#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
