class Gallery < ActiveRecord::Base

  has_many :photos
  belongs_to :user
  belongs_to :default_photo, class_name: 'Photo', optional: true

  validates_uniqueness_of :code

  def self.public_recent
    Gallery.where('private_key is null').order('gallery_on desc').limit(6).all
  end

  def self.find_public(name = nil, gallery_on = nil)
    results = Gallery.where('private_key is null')
    results = results.where('name like ?', "%#{name}%") if name
    results = results.where('gallery_on = ?', gallery_on) if gallery_on
    results
  end

  def self.find_private(key)
    Gallery.where('private_key = ?', key).first
  end

  def self.new_private_key(priv = nil)
    return nil unless '1'.eql? priv
    chars = ('a'..'z').to_a + ('1'..'9').to_a
    Array.new(20, '').collect{chars[rand(chars.size)]}.join
  end

  def photo_count
    photos.size
  end

  def default_photo_obj
    default_photo || photos.first
  end
end
