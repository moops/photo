#require 'rubygems'
require 'mini_magick'
require 'aws/s3'
 
class Photo < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  attr_accessible :gallery_id, :artist, :caption, :sequence, :views, :img, :photo_at, :shutter_speed, :aperture, 
    :focal_length, :iso, :exposure_mode, :flash, :exposure_compensation, :camera_model
  
  belongs_to :gallery
  has_many :comments
  
  mount_uploader :img, ImageUploader
    
  def remove_source
    
      AWS::S3::Base.establish_connection!(
          :access_key_id     => S3_CONFIG[Rails.env]['access_key_id'],
          :secret_access_key => S3_CONFIG[Rails.env]['secret_access_key']
      )
      
      AWS::S3::S3Object.delete("#{gallery.code}/thumbnails/#{self.img}", bucket_name)
      AWS::S3::S3Object.delete("#{gallery.code}/#{self.img}", bucket_name)
  end
  
  def source_url
    "http://s3.amazonaws.com/#{bucket_name}/foo/#{gallery.code}/bar/#{img}"
  end
  
  def source_thumb_url
    "http://s3.amazonaws.com/#{bucket_name}/#{gallery.code}/thumbnails/#{img}"
  end

  def next
    n = nil
    if self.sequence
      n = Photo.find(:first, :conditions => ["gallery_id = ? and sequence = ?",self.gallery_id,self.sequence + 1])
    end
    n
  end

  def previous
    p = nil
    if self.sequence
      p = Photo.find(:first, :conditions => ["gallery_id = ? and sequence = ?",self.gallery_id,self.sequence - 1])
    end
    p
  end

  def extract_exif(image)
    if (image['EXIF:DateTimeOriginal']) 
      begin
        self.photo_at= DateTime.strptime(image['EXIF:DateTimeOriginal'].strip, '%Y:%m:%d %H:%M:%S')
      rescue
      end
    end
    self.shutter_speed= image['EXIF:ExposureTime'].strip if image['EXIF:ExposureTime']
    self.aperture= image['EXIF:FNumber'].strip if image['EXIF:FNumber']
    self.focal_length= image['EXIF:FocalLengthIn35mmFilm'].strip + (image['EXIF:FocalLengthIn35mmFilm'].strip.length > 0 ? 'mm' : '') if image['EXIF:FocalLengthIn35mmFilm']
    self.iso= image['EXIF:ISOSpeedRatings'].strip if image['EXIF:ISOSpeedRatings']
    self.exposure_mode= image['EXIF:ExposureProgram'].strip if image['EXIF:ExposureProgram']
    self.flash= image['EXIF:Flash'].strip if image['EXIF:Flash']
    self.exposure_compensation= image['EXIF:ExposureBiasValue'].strip if image['EXIF:ExposureBiasValue']
    self.camera_model= image['EXIF:Model'].strip if image['EXIF:Model']
  end
  
  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "id" => read_attribute(:id),
      "artist" => read_attribute(:artist),
      "caption" => read_attribute(:caption),
      "name" => read_attribute(:img),
      "size" => img.size,
      "url" => img.url,
      "thumbnail_url" => img.thumb.url,
      "delete_url" => gallery_photo_path(gallery, id),
      "delete_type" => "DELETE" 
     }
  end
  
  private
  
  def bucket_name
    'raceweb_photo' << (Rails.env.production? ? '' : '_' << Rails.env)
  end
  
end


