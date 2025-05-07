module V3
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
          task.user_id = User.first.id # For testing and benchmarking purposes

          if task.save
            status 201
            ActiveModelSerializers::SerializableResource.new(
          task,
          serializer: TaskSerializer
        ).as_json
          else
            status 422
            { errors: task.errors.full_messages }
          end
        end
      end
  end
end
