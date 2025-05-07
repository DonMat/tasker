module V1
  module Commentable
    class Index < Grape::API
      desc "Get all comments for #{configuration[:commentable_type]}"

      get do
        comments = configuration[:commentable_type].constantize.find(params[:commentable_id]).comments
        present comments, with: Entities::V1::Comments::Comment
      end
    end
  end
end
