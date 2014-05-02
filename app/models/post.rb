class Post < ActiveRecord::Base
	acts_as_list
	belongs_to :page
end
