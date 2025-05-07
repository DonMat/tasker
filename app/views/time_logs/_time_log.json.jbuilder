json.id time_log.id
json.task_id time_log.task_id
json.duration_in_minutes time_log.duration_in_minutes
json.recorded_at time_log.recorded_at

json.user do
  json.partial! "users/user", user: time_log.user
end
