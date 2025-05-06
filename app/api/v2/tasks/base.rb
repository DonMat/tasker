class V2::Tasks::Base < Grape::API
  resources :tasks do
    mount V2::Tasks::MarkDone
  end
end
