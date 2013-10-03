json.extract! @photo, :file_name, :image_url, :created_at, :updated_at
json.comments(@photo.comments) do |comment|
  json.url api_v1_user_photo_comment_url(@photo.user, @photo, comment)
end
