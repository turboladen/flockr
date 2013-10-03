json.extract! @user, :email, :username, :created_at, :updated_at
json.photos(@user.photos) do |photo|
  json.file_name photo.file_name
  json.url api_v1_user_photo_url(@user, photo)
end
