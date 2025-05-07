module V1
  module Tasks
    class Show < Grape::API
      desc "Get a specific task"
      params do
        requires :id, type: Integer, desc: "Task ID"
        optional :include_time_logs, type: Boolean, default: false, desc: "Include time logs in the response"
        optional :include_comments, type: Boolean, default: false, desc: "Include comments in the response"
      end

      get ":id" do
        include_time_logs = ActiveModel::Type::Boolean.new.cast(params[:include_time_logs])
        include_comments = ActiveModel::Type::Boolean.new.cast(params[:include_comments])

        task_query = Task.all
        task_query = task_query.includes(time_logs: :user) if include_time_logs
        task_query = task_query.includes(comments: :user) if include_comments

        task = task_query.find_by(id: params[:id]) #.where(user_id: current_user.id).find_by(id: params[:id])

        if task
          present task, with: Entities::V1::Tasks::Task, include_time_logs: include_time_logs, include_comments: include_comments
        else
          status 404
          { error: "Task not found" }
        end
      end
    end
  end
end
