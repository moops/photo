class Gallery < ApplicationRecord
  has_many :photos, dependent: :delete_all
  belongs_to :user
  belongs_to :default_photo, class_name: 'Photo', optional: true

  validates :code, uniqueness: true

  def self.public_recent
    Gallery.where('private_key is null').order('gallery_on desc').limit(6).all
  end

  def self.search(q, current_user = nil, gallery_on = nil)
    return [] if q.blank?
    galleries = Gallery.where(private_key: q)
    return galleries if galleries.present?
    galleries = Gallery.where(private_key: nil).or(Gallery.where(user: current_user))
    galleries = galleries.where('name like ?', "%#{q}%")
    galleries = galleries.where('gallery_on = ?', gallery_on) if gallery_on
    galleries
  end

  def update_private_key(private_key_param = nil)
    if private_key_param == '1'
      unless private?
        chars = ('a'..'z').to_a + ('1'..'9').to_a
        self.private_key = Array.new(20, '').collect { chars[rand(chars.size)] }.join
      end
    else
      self.private_key = nil
    end
    private_key
  end

  def photo_count
    photos.size
  end

  def private?
    private_key.present?
  end

  def def_photo
    default_photo || photos.first
  end
end
