module V2
  module TimeLogs
    class Base < Grape::API
      resources :time_logs do
        mount V2::TimeLogs::Create
        mount V2::TimeLogs::Index

        mount V1::Commentable::Base, with: { commentable_type: "TimeLog" }
      end
    end
  end
end
