class V2::Tasks::Base < Grape::API
  resources :tasks do
    mount V2::Tasks::MarkDone
    mount V1::Commentable::Base, with: { commentable_type: "Task" }
  end
end
