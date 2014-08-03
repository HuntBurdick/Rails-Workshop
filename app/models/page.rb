class Page < ActiveRecord::Base
	acts_as_list
	validates :name, :presence => true, :uniqueness => true

	has_many :posts, dependent: :destroy

	has_attached_file :image, :styles => { :large => "800x800>", :medium => "250x250#", :thumb => "150x150#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def label
  	"Pages"
  end

  def form_title
  	name.downcase.gsub(' ', '_')
  end

	extend FriendlyId
  	friendly_id :name, use: :slugged
end
