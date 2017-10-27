json.extract! photo, :id, :artist, :caption, :sequence, :views, :img, :created_at, :updated_at
json.url photo_url(photo, format: :json)
