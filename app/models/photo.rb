require 'rubygems'
require 'mini_magick'
require 'aws/s3'
 
class Photo < ActiveRecord::Base

  belongs_to :gallery
  has_many :photo_comments
  
  def save_source(upload)
  
    AWS::S3::Base.establish_connection!(
        :access_key_id     => S3_CONFIG[Rails.env]['access_key_id'],
        :secret_access_key => S3_CONFIG[Rails.env]['secret_access_key']
    )
    
    path = File.join('tmp', upload.original_filename)
    File.open(path, 'wb') { |f| f.write(upload.read) }
    filename = "tmp/#{upload.original_filename}"
    original = MiniMagick::Image.from_file(filename)
    set_exif(original)
    web = original
    web.resize '640x640'
    web.write("tmp/web_#{upload.original_filename}")
    thumb = original
    thumb.resize '130x130'
    thumb.write("tmp/thumb_#{upload.original_filename}")
    
    file_key = "#{gallery.code}/#{upload.original_filename}"
    AWS::S3::S3Object.store(file_key, open("tmp/web_#{upload.original_filename}", 'rb'), bucket_name, :access => :public_read)
    thumb_key = "#{gallery.code}/thumbnails/#{upload.original_filename}"
    AWS::S3::S3Object.store(thumb_key, open("tmp/thumb_#{upload.original_filename}", 'rb'), bucket_name, :access => :public_read)
  end
  
  def source_url
    "http://s3.amazonaws.com/#{bucket_name}/#{gallery.code}/#{filename}"
  end
  
  def source_thumb_url
    "http://s3.amazonaws.com/#{bucket_name}/#{gallery.code}/thumbnails/#{filename}"
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

  def set_exif(img)
    self.photo_at= img['EXIF:DateTimeOriginal']
    self.shutter_speed= ['EXIF:ExposureTime']
    self.aperture= ['EXIF:ApertureValue']
    self.focal_length= ['EXIF:FocalLength']
    self.iso= ['EXIF:ISOSpeedRatings']
    self.exposure_mode= ['EXIF:ExposureProgram']
    self.flash= ['EXIF:Flash']
    self.exposure_compensation= ['EXIF:ExposureBiasValue']
    self.camera_model= ['EXIF:Model']
    self.save
  end
  
  private
  
  def bucket_name
    'raceweb_photo' << (Rails.env.production? ? '' : '_' << Rails.env)
  end
  
end

class Exif
  require 'rubygems'
  require 'exifr'
  attr_accessor :photo_id, :shutter_speed, :iso, :aperture, :focal_length, :exp_mode, 
                :date, :time, :flash, :exp_compensation, :camera_model
  
  def initialize(id,path)
    exif_details = MiniExiftool.new(path)
    @photo_id = id
    @date = exif_details['DateTimeOriginal'].strftime("%b %d, %Y")
    @time = exif_details['DateTimeOriginal'].strftime("%H:%M:%S")
    @shutter_speed = exif_details['ExposureTime']
    @aperture = exif_details['fnumber']
    @focal_length = exif_details['FocalLength']
    @iso = exif_details['ISO']
    @exp_mode = exif_details['exposureprogram']   
    @flash = exif_details['Flash']
    @exp_compensation = exif_details['exposurecompensation']
    @camera_model = exif_details['Model']
  end

end
