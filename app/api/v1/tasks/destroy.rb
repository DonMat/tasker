module V1
  module Tasks
    class Destroy < Grape::API
      desc "Delete a task"
      params do
        requires :id, type: Integer, desc: "Task ID"
      end

      delete ":id" do
        task = Task.where(user_id: current_user.id).find_by(id: params[:id])

        if task.nil?
          status 404
          { error: "Task not found" }
        elsif task.destroy
          status 204
        else
          status 422
          { errors: task.errors.full_messages }
        end
      end
    end
  end
end
