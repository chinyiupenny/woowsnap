class Product < ActiveRecord::Base
  attr_accessible :description, :title, :price, :latitude, :longitude, :shop, :address

  validates_presence_of :title

  has_many :photos
  
  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['title LIKE ? OR description LIKE ?', search_condition, search_condition])
  end
end
