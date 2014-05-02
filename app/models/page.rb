class Page < ActiveRecord::Base
	acts_as_list
	validates :name, :presence => true, :uniqueness => true

	has_many :posts, dependent: :destroy
end
