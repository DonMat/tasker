class V1::Base < Grape::API
  version "v1", "v2", using: :path
  content_type :json, "application/json; charset=utf-8"
  prefix :api

  mount V1::Tasks::Base
end
