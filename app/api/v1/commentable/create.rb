module V1
  module Commentable
    class Create < Grape::API
      desc "Create a comment for #{configuration[:commentable_type]}"
      params do
        requires :body, type: String, desc: "The body of the comment"
      end

      post do
        comment = configuration[:commentable_type].constantize.find(params[:commentable_id]).comments.create(body: params[:body], user: current_user)
        {
          comment: comment,
          message: "Comment created successfully"
        }
      end
    end
  end
end
