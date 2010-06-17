class Photo < ActiveRecord::Base

  belongs_to :gallery
  has_many :photo_comments
  attr_accessor :exif
    
  has_attachment :storage => :file_system, 
                 :resize_to => [550,550], 
                 :thumbnails => { :thumb => [130, 130] },
                 :content_type => :image,
                 :max_size => 3.megabyte    
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
