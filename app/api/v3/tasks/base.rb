module V3
  module Tasks
    class Base < Grape::API
      resources :tasks do
        mount V3::Tasks::Index
        mount V3::Tasks::Show
        mount V3::Tasks::Create
      end
    end
  end
end
