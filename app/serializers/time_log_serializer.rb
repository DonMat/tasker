class TimeLogSerializer < ActiveModel::Serializer
  attributes :id, :task_id, :duration_in_minutes, :recorded_at, :created_at, :updated_at

  belongs_to :user, serializer: UserSerializer, include: true
  has_many :comments, if: :include_comments?

  def include_comments?
    instance_options[:include_comments]
  end
end
