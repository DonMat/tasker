
  module Entities
    module V1
      module Tasks
        class Task < Grape::Entity
          expose :id, documentation: { type: "Integer", desc: "Task ID" }
          expose :title, documentation: { type: "String", desc: "Title of the task" }
          expose :done, documentation: { type: "Boolean", desc: "Done flag" }
          expose :priority, documentation: { type: "String", desc: "Priority of the task" }
          expose :created_at, documentation: { type: "DateTime", desc: "Task creation timestamp" }
          expose :updated_at, documentation: { type: "DateTime", desc: "Task last update timestamp" }
          expose :time_logs, using: Entities::V1::TimeLogs::TimeLog, if: { include_time_logs: true }, documentation: { type: "Array", desc: "Time logs of the task" }
          expose :comments, using: Entities::V1::Comments::Comment, if: { include_comments: true }, documentation: { type: "Array", desc: "Comments on the task" }
        end
      end
    end
  end
