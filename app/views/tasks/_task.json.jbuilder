json.extract! task, :id, :title, :done, :done_at, :priority, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)
