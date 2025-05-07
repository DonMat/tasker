class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :priority, :done, :created_at, :updated_at

  has_many :time_logs, serializer: TimeLogSerializer, if: :include_time_logs?
  has_many :comments, serializer: CommentSerializer, if: :include_comments?

  def include_time_logs?
    instance_options[:include_time_logs]
  end

  def include_comments?
    instance_options[:include_comments]
  end
end
