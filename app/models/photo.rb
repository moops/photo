require 'rubygems'
require 'mini_magick'
require 'aws/s3'
 
class Photo < ActiveRecord::Base

  belongs_to :gallery
  has_many :photo_comments
  attr_accessor :exif
      
  def photo_on
    #TODO change to exif info
    created_at
  end
  
  def save_source(upload)
  
    AWS::S3::Base.establish_connection!(
        :access_key_id     => 'AKIAJXI3Y2RMZJL3WOLA',
        :secret_access_key => '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'
    )
    
    bucket_name = 'raceweb_photo'
    unless Rails.env.production?
      bucket_name << '_' << Rails.env
    end
    logger.info("bucket name [#{bucket_name}]")
    bucket = AWS::S3::Bucket.find(bucket_name)
    logger.info("bucket [#{bucket.inspect}]")
    
    path = File.join('tmp', upload.original_filename)
    File.open(path, 'wb') { |f| f.write(upload.read) }
    filename = "tmp/#{upload.original_filename}"
    original = MiniMagick::Image.from_file(filename)
    web = MiniMagick::Image.from_file(filename)
    web.resize '550x550'
    web.write("tmp/web_#{upload.original_filename}")
    thumb = MiniMagick::Image.from_file(filename)
    thumb.resize '150x150'
    thumb.write("tmp/thumb_#{upload.original_filename}")
    
    key = "#{gallery.code}_#{upload.original_filename}"
    logger.info("key[#{key}]")
    logger.info("size[#{bucket.objects.size}]")
    AWS::S3::S3Object.store(key, open("tmp/web_#{upload.original_filename}"), bucket_name)
    
    logger.info("size[#{bucket.objects.size}]")
  end


  def self.resize_and_crop(image, square_size)
    geometry = to_geometry(
      square_size, square_size)
    if image[:width] < image[:height]
      shave_off = ((
        image[:height]-
        image[:width])/2).round
      image.shave("0x#{shave_off}")
    elsif image[:width] > image[:height]
      shave_off = ((
        image[:width]-
        image[:height])/2).round
      image.shave("#{shave_off}x0")
    end
    image.resize(geometry)
    return image
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

  def set_exif
    begin
      @exif = Exif.new(self.id,"#{RAILS_ROOT}/public/photos/#{self.gallery.code}/#{self.filename}")
    rescue
      nil
    end
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
