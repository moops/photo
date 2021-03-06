# image uploader
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage in config/initializers/carrierwave.rb

  process :extract_exif
  process resize_to_fit: [800, 800]
  process :fix_rotation

  def extract_exif
    manipulate! do |img|
      model.extract_exif(img)
      img
    end
  end

  def fix_rotation
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  def store_dir
    dir = model.gallery.code
    dir = "uploads/#{dir}" unless Rails.env.production?
    dir
  end

  version :thumb do
    # change naming from thumb_xxx.jpg to xxx-thumb.jpg
    def full_filename(for_file = model.img.file)
      parts     = for_file.split('.')
      extension = parts[-1]
      name      = parts[0...-1].join('.')
      "#{name}-#{version_name}.#{extension}"
    end

    process resize_to_fill: [120, 120]
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
