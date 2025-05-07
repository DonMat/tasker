module V3
  module Tasks
    class Index < Grape::API
      desc "Get all tasks"
      params do
        optional :priority, type: String, desc: "Filter by priority"
        optional :done, type: Boolean, desc: "Filter by completion status"
        optional :page, type: Integer, default: 1
        optional :per_page, type: Integer, default: 20
      end

      get do
        tasks = Task.all # For testing and benchmarking purposes

        if params[:priority].present?
          tasks = tasks.where(priority: params[:priority])
        end

        if params[:done].present?
          tasks = tasks.where(done: params[:done])
        end

        # tasks = tasks.page(params[:page]).per(params[:per_page])
        ActiveModelSerializers::SerializableResource.new(
          tasks,
          each_serializer: TaskSerializer
        ).as_json
      end
    end
  end
end
