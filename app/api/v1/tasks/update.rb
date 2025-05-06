module V1
  module Tasks
    class Update < Grape::API
      helpers do
        params :task_params do
          requires :title, type: String, desc: "Task title"
          requires :priority, type: String, values: Task.priorities.keys, desc: "Task priority"
          optional :done, type: Boolean, default: false, desc: "Task completion status"
          optional :done_at, type: DateTime, desc: "When the task was completed"
        end
      end

      desc "Update a task"
      params do
        requires :id, type: Integer, desc: "Task ID"
        use :task_params
      end
      put ":id" do
        task = Task.where(user_id: current_user.id).find_by(id: params[:id])

        if task.nil?
          status 404
          { error: "Task not found" }
        elsif task.update(declared(params, include_missing: false))
          present task, with: Entities::V1::Tasks::Task
        else
          status 422
          { errors: task.errors.full_messages }
        end
      end
    end
  end
end
