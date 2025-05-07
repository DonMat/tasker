module Entities
  module V1
    module Users
      class User < Grape::Entity
        expose :id, documentation: { type: "Integer", desc: "User ID" }
        expose :name, documentation: { type: "String", desc: "Full name of the user" }
        expose :email_address, as: :email, documentation: { type: "String", desc: "Email address of the user" }
        expose :created_at, documentation: { type: "DateTime", desc: "Account creation timestamp" }
      end
    end
  end
end
