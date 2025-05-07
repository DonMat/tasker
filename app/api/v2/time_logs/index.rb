module V2
  module TimeLogs
    class Index < Grape::API
      desc "Get list of time logs for current user"

      get do
        time_logs = current_user.time_logs
        present time_logs, with: Entities::V1::TimeLogs::TimeLog
      end
    end
  end
end
