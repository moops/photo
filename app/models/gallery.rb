class Gallery < ApplicationRecord
  has_many :photos, dependent: :delete_all
  belongs_to :user
  belongs_to :default_photo, class_name: 'Photo', optional: true

  validates :code, uniqueness: true

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
    Gallery.find_by(private_key: key)
  end

  def self.new_private_key(priv = nil)
    return nil unless '1'.eql? priv
    chars = ('a'..'z').to_a + ('1'..'9').to_a
    Array.new(20, '').collect { chars[rand(chars.size)] }.join
  end

  def photo_count
    photos.size
  end

  def default_photo
    # return self[:default_photo] if self[:default_photo]
    # self[:default_photo_id] = photos.first.id if photos.present?
    # save
    # Photo.find(self[:default_photo_id])

    self[:default_photo] || photos.order(:id).first
  end

  # def default_photo_obj
  #   binding.pry
  #   if default_photo_id.nil? && !photos.empty?
  #     self.default_photo = photos.first
  #     save
  #   end
  #   self.default_photo
  # end
end
