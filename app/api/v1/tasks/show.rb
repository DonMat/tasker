module V1
  module Tasks
    class Show < Grape::API
      desc "Get a specific task"
      params do
        requires :id, type: Integer, desc: "Task ID"
        optional :include_time_logs, type: Boolean, default: false, desc: "Include time logs in the response"
      end

      get ":id" do
        task = Task.where(user_id: current_user.id).find_by(id: params[:id])

        if task
          present task, with: Entities::V1::Tasks::Task, include_time_logs: ActiveModel::Type::Boolean.new.cast(params[:include_time_logs])
        else
          status 404
          { error: "Task not found" }
        end
      end
    end
  end
end
