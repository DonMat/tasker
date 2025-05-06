class V1::Tasks::Base < Grape::API
  resources :tasks do
    mount V1::Tasks::Create
    mount V1::Tasks::Index
    mount V1::Tasks::Show
    mount V1::Tasks::Update
    mount V1::Tasks::Destroy
  end
end
