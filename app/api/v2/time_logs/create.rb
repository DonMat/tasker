module V2
  module TimeLogs
    class Create < Grape::API
      desc "Create a time log for a task"
      params do
        requires :task_id, type: Integer, desc: "The ID of the task"
        requires :duration_in_minutes, type: Integer, desc: "Duration in minutes"
        requires :recorded_at, type: DateTime, desc: "Date and time of the time log"
      end

      post do
        task = ::Task.find_by(id: params[:task_id], user: current_user.id)
        if task.nil?
          error!("Task not found", 404)
        end

        time_log = task.time_logs.create!(
          duration_in_minutes: params[:duration_in_minutes],
          recorded_at: params[:recorded_at],
          user: current_user
        )
        present time_log, with: Entities::V1::TimeLogs::TimeLog
      end
    end
  end
end
