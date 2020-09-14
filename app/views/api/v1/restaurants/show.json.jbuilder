json.extract! @restaurant, :id, :name, :address
json.owner @restaurant.user.email
json.comments @restaurant.comments do |comment|
  json.extract! comment, :id, :content
  json.user do
    json.id comment.user.id
    json.email comment.user.email
  end
end
