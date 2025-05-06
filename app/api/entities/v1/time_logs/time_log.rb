
  module Entities
    module V1
      module TimeLogs
        class TimeLog < Grape::Entity
          expose :id, documentation: { type: "Integer", desc: "ID of the time log" }
          expose :task_id, documentation: { type: "Integer", desc: "ID of the task associated with the time log" }
          expose :duration_in_minutes, documentation: { type: "Integer", desc: "Duration in minutes" }
          expose :recorded_at, documentation: { type: "DateTime", desc: "Date of TimeLog record" }
          expose :user, with: Entities::V1::Users::User, documentation: { type: "Hash", desc: "User associated with the time log" }
        end
      end
    end
  end
