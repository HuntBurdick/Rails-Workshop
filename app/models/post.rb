class Post < ActiveRecord::Base
	acts_as_list
	belongs_to :page
	validates :title, :presence => true, :uniqueness => true
end
