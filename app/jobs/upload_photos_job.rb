class UploadPhotosJob < ApplicationJob
  queue_as :default

  def perform(params)
    params[:photo_includes].each do |index|
      Rails.logger.info("creating photo for #{index}")
      i = index.to_i
      # create a photo
      @gallery.photos.create(
        artist: params[:photo_artists][i],
        caption: params[:photo_captions][i],
        views: 0,
        sequence: i,
        img: params[:photos][i]
      )
    end
  end
end
