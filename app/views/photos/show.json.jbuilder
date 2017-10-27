json.extract! @photo, :id, :gallery_id, :artist, :caption, :views, :img, :created_at, :updated_at
json.url photo_url(@photo, format: :json)
