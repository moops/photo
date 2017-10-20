json.extract! @gallery, :id, :name, :code, :private_key, :created_at, :updated_at
json.url gallery_url(@gallery, format: :json)
