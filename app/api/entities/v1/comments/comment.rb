module Entities
  module V1
    module Comments
      class Comment < Grape::Entity
        expose :id, documentation: { type: "Integer", desc: "Comment ID" }
        expose :body, documentation: { type: "String", desc: "Comment body" }
        expose :created_at, documentation: { type: "DateTime", desc: "Comment creation timestamp" }
        expose :user, using: Entities::V1::Users::User
      end
    end
  end
end
