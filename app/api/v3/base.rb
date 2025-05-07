class V3::Base < Grape::API
  version "v3", using: :path
  content_type :json, "application/json; charset=utf-8"
  prefix :api

  mount V3::Tasks::Base
end
