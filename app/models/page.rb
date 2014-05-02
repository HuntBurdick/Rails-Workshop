class Page < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true

	has_many :posts, dependent: :destroy
end
