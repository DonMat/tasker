class V2::Tasks::MarkDone < Grape::API
  desc "Mark a task as done"
  params do
    requires :id, type: Integer, desc: "Task ID"
  end

  put ":id/mark_done" do
    task = Task.where(user_id: current_user.id).find_by(id: params[:id])

    if task.nil?
      status 404
      { error: "Task not found" }
    elsif task.update(done: true, done_at: Time.current)
      present task, with: Entities::V2::Tasks::Task
    else
      status 422
      { errors: task.errors.full_messages }
    end
  end
end
