module V2
  class TasksController < ApplicationController
    allow_unauthenticated_access

    def index
      tasks = Task.all # For testing and benchmarking purposes

      if params[:priority].present?
        tasks = tasks.where(priority: params[:priority])
      end

      if params[:done].present?
        tasks = tasks.where(done: params[:done])
      end

      render json: ActiveModelSerializers::SerializableResource.new(
        tasks,
        each_serializer: TaskSerializer
      ).as_json
    end

    def show
      @include_time_logs = ActiveModel::Type::Boolean.new.cast(params[:include_time_logs])
      @include_comments = ActiveModel::Type::Boolean.new.cast(params[:include_comments])

      task_query = Task.all
      task_query = task_query.includes(time_logs: :user) if @include_time_logs
      task_query = task_query.includes(comments: :user) if @include_comments

      task = task_query.find(params[:id]) # For testing and benchmarking purposes

      render json: ActiveModelSerializers::SerializableResource.new(
        task,
        serializer: TaskSerializer,
        include_time_logs: params[:include_time_logs],
        include_comments: params[:include_comments],
        include: {
              time_logs: {
                user: {}
              },
              comments: {
                user: {}
              }
            }
      ).as_json
    end

    def create
      task = Task.new(task_params)
      task.user_id = User.first.id # For testing and benchmarking purposes

      if task.save
        render json: ActiveModelSerializers::SerializableResource.new(
          task,
          serializer: TaskSerializer
        ).as_json, status: :created
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def task_params
      params.require(:task).permit(:title, :description, :priority, :done)
    end
  end
end
