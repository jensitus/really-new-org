json.extract! photo_gallery, :id, :title, :description, :last_updated_by_id, :created_at, :updated_at
json.url photo_gallery_url(photo_gallery, format: :json)
