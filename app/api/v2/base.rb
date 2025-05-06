class V2::Base < Grape::API
  version "v2", using: :path
  content_type :json, "application/json; charset=utf-8"
  prefix :api

  mount V2::Tasks::Base
end
