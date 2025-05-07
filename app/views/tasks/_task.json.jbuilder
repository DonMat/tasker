json.id task.id
json.title task.title
json.done task.done
json.priority task.priority
json.created_at task.created_at
json.updated_at task.updated_at

if local_assigns[:include_time_logs]
  json.time_logs task.time_logs do |time_log|
    json.partial! "time_logs/time_log", time_log: time_log
  end
end
