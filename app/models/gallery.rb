class Gallery < ActiveRecord::Base
  
  has_many :photos
  belongs_to :user
  
  validates_uniqueness_of :code

  def self.public_recent
    Gallery.where('private_key is null').order('gallery_on desc').limit(6).all
  end
               
  def self.find_public(name=nil, gallery_on=nil)
    results = Gallery.where('private_key is null')
    results = results.where('name like ?', "%#{name}%") if name
    results = results.where('gallery_on = ?', gallery_on) if gallery_on
    results
  end

  def self.find_private(key)
    Gallery.where('private_key = ?', key).first
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
    photos.where('img = ?', default_photo).first or photos.first
  end
  
end
