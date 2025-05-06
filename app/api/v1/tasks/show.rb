module V1
  module Tasks
    class Show < Grape::API
      desc "Get a specific task"
      params do
        requires :id, type: Integer, desc: "Task ID"
      end

      get ":id" do
        task = Task.where(user_id: current_user.id).find_by(id: params[:id])

        if task
          present task, with: Entities::V1::Tasks::Task, include_time_logs: true
        else
          status 404
          { error: "Task not found" }
        end
      end
    end
  end
end
