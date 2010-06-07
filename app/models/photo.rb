class Photo < ActiveRecord::Base

  belongs_to :gallery
  has_many :photo_comments
  attr_accessor :exif
    
  has_attached_file :source, :storage => :s3, 
                             :styles => { :original => '550x550>', :thumb => '130x130' }, 
                             :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                             :path => ":attachment/:id/:style.:extension"
    
    validates_attachment_presence :source
    validates_attachment_size :source, :less_than => 3.megabytes
    validates_attachment_content_type :source, :content_type => ['image/jpeg', 'image/png']
    
  attr_protected :source_file_name, :source_content_type, :source_size
    
  def photo_on
    #TODO change to exif info
    created_at
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
