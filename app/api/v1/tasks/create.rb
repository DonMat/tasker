module V1
  module Tasks
    class Create < Grape::API
      desc "Create a new task"
      params do
        requires :title, type: String, desc: "Task title"
        requires :priority, type: String, values: Task.priorities.keys, desc: "Task priority"
        optional :done, type: Boolean, default: false, desc: "Task completion status"
        optional :done_at, type: DateTime, desc: "When the task was completed"
      end

      post do
        task = Task.new(declared(params))
        task.user_id = current_user.id

        if task.save
          status 201
          present task, with: Entities::V1::Tasks::Task
        else
          status 422
          { errors: task.errors.full_messages }
        end
      end
    end
  end
end
