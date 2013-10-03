json.array!(@users) do |user|
  json.extract! user, :email, :username
  json.url api_v1_user_url(user, format: :json)
end
