json.array!(@users) do |user|
  json.extract! user, :username
  json.url api_v1_user_url(user, format: :json)
end
