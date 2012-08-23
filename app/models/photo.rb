#require 'rubygems'
#require 'mini_magick'
#require 'aws/s3'
 
class Photo < ActiveRecord::Base

  attr_accessible :gallery_id, :image, :artist, :caption, :sequence, :views, :filename, :photo_at, :shutter_speed, :aperture, 
    :focal_length, :iso, :exposure_mode, :flash, :exposure_compensation, :camera_model
  
  belongs_to :gallery
  has_many :photo_comments
  
  mount_uploader :image, ImageUploader
  
  def save_source(upload)
  
    AWS::S3::Base.establish_connection!(
        :access_key_id     => S3_CONFIG[Rails.env]['access_key_id'],
        :secret_access_key => S3_CONFIG[Rails.env]['secret_access_key']
    )
    
    # write the original to the temp dir
    path = File.join('tmp', upload.original_filename)
    File.open(path, 'wb') { |f| f.write(upload.read) }
    filename = "tmp/#{upload.original_filename}"
    original = MiniMagick::Image.from_file(filename)
    set_exif(original)
    
    # write the web and thumb version to the temp dir
    web = original
    web.resize '640x640'
    web.write("tmp/web_#{upload.original_filename}")
    thumb = original
    thumb.resize '130x130'
    thumb.write("tmp/thumb_#{upload.original_filename}")
    
    # write to s3
    file_key = "#{gallery.code}/#{upload.original_filename}"
    AWS::S3::S3Object.store(file_key, open("tmp/web_#{upload.original_filename}", 'rb'), bucket_name, :access => :public_read)
    thumb_key = "#{gallery.code}/thumbnails/#{upload.original_filename}"
    AWS::S3::S3Object.store(thumb_key, open("tmp/thumb_#{upload.original_filename}", 'rb'), bucket_name, :access => :public_read)
  end
  
  def set_exif_from_s3()
      AWS::S3::Base.establish_connection!(
          :access_key_id     => S3_CONFIG[Rails.env]['access_key_id'],
          :secret_access_key => S3_CONFIG[Rails.env]['secret_access_key']
      )
      
      path = File.join('tmp', self.filename)
      # get from s3
      file_key = "#{gallery.code}/#{self.filename}"
      File.open("tmp/#{self.filename}", 'wb') { |f| f.write(AWS::S3::S3Object.value(file_key, bucket_name)) }
      tmp_file = MiniMagick::Image.from_file("tmp/#{self.filename}")
      set_exif(tmp_file)
  end
  
  def remove_source
    
      AWS::S3::Base.establish_connection!(
          :access_key_id     => S3_CONFIG[Rails.env]['access_key_id'],
          :secret_access_key => S3_CONFIG[Rails.env]['secret_access_key']
      )
      
      AWS::S3::S3Object.delete("#{gallery.code}/thumbnails/#{self.filename}", bucket_name)
      AWS::S3::S3Object.delete("#{gallery.code}/#{self.filename}", bucket_name)
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
    if (img['EXIF:DateTimeOriginal']) 
      begin
        self.photo_at= DateTime.strptime(img['EXIF:DateTimeOriginal'].strip, '%Y:%m:%d %H:%M:%S')
      rescue
      end
    end
    self.shutter_speed= img['EXIF:ExposureTime'].strip
    self.aperture= img['EXIF:FNumber'].strip
    self.focal_length= img['EXIF:FocalLengthIn35mmFilm'].strip + (img['EXIF:FocalLengthIn35mmFilm'].strip.length > 0 ? 'mm' : '')
    self.iso= img['EXIF:ISOSpeedRatings'].strip
    self.exposure_mode= img['EXIF:ExposureProgram'].strip
    self.flash= img['EXIF:Flash'].strip
    self.exposure_compensation= img['EXIF:ExposureBiasValue'].strip
    self.camera_model= img['EXIF:Model'].strip
    self.save
  end
  
  private
  
  def bucket_name
    'raceweb_photo' << (Rails.env.production? ? '' : '_' << Rails.env)
  end
  
end


