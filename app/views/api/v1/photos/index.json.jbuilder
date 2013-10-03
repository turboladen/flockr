json.array!(@user.photos) do |photo|
  json.extract! photo, :file_name, :image_url
  json.url api_v1_user_photo_url(@user, photo, format: :json)
end
