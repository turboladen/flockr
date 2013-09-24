json.array!(@user.photos) do |photo|
  json.extract! photo, :file_name, :path
  json.url user_photo_url(@user, photo, format: :json)
end
