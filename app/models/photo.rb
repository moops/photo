# photo model
class Photo < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :gallery
  has_many :comments
  before_create :set_defaults

  mount_uploader :img, ImageUploader

  def increment
    self.views += 1
    save
  end

  def extract_exif(image)
    if image['EXIF:DateTimeOriginal']
      begin
        self.photo_at = DateTime.strptime(image['EXIF:DateTimeOriginal'].strip, '%Y:%m:%d %H:%M:%S')
      rescue
      end
    end
    self.shutter_speed = image['EXIF:ExposureTime'].strip if image['EXIF:ExposureTime']
    self.aperture = image['EXIF:FNumber'].strip if image['EXIF:FNumber']
    self.focal_length = image['EXIF:FocalLengthIn35mmFilm'].strip + (image['EXIF:FocalLengthIn35mmFilm'].strip.length > 0 ? 'mm' : '') if image['EXIF:FocalLengthIn35mmFilm']
    self.iso = image['EXIF:ISOSpeedRatings'].strip if image['EXIF:ISOSpeedRatings']
    self.exposure_mode = image['EXIF:ExposureProgram'].strip if image['EXIF:ExposureProgram']
    self.flash = image['EXIF:Flash'].strip if image['EXIF:Flash']
    self.exposure_compensation = image['EXIF:ExposureBiasValue'].strip if image['EXIF:ExposureBiasValue']
    self.camera_model = image['EXIF:Model'].strip if image['EXIF:Model']
  end

  def description
    caption.empty? ? img.file.filename : caption
  end

  protected

  def set_defaults
    self.artist = gallery.user.name unless artist
    self.caption = img.model.read_attribute(:img) unless caption
  end
end
