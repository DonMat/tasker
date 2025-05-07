json.id comment.id
json.body comment.body
json.created_at comment.created_at

json.user do
  json.partial! "users/user", user: comment.user
end
