class Gallery < ActiveRecord::Base
  
  attr_accessible :name, :code, :private_key, :gallery_on, :default_photo

  has_many :photos
  belongs_to :user
  
  validates_uniqueness_of :code

  def self.recent
    Gallery.where('private_key is null').order('gallery_on desc').limit(6).all
  end
               
  def self.find_public(name=nil, gallery_on=nil)
    results = Gallery.where('private_key is null')
    results = results.where('name like ?', "%#{name}%") if name
    results = results.where('gallery_on = ?', gallery_on) if gallery_on
    results
  end

  def self.find_private
    Gallery.find(:first, :conditions => ['private_key = ?',private_key])
  end

  def photo_count
    photos.size
  end
  
  def photo_attributes=(photo_attributes)
    photo_attributes.each do |attributes|
      photos.build(attributes)
    end
  end
  
  def default_photo_obj
    photos.where('img = ?', default_photo).first
  end
  
end
