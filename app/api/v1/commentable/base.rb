module V1
  module Commentable
    class Base < Grape::API
      route_param :commentable_id do
        resources :comments do
          mount V1::Commentable::Create, with: { commentable_type: configuration[:commentable_type] }
          mount V1::Commentable::Index, with: { commentable_type: configuration[:commentable_type] }
        end
      end
    end
  end
end
