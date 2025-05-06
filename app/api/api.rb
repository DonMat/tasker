class API < Grape::API
  version "v1", "v2", using: :path

  logger.formatter = GrapeLogging::Formatters::Default.new
  use GrapeLogging::Middleware::RequestLogger, logger: logger, include: [
    GrapeLogging::Loggers::FilterParameters.new
  ]

  format :json
  content_type :json, "application/json; charset=utf-8"
  prefix :api

  helpers do
    def current_user
      @current_user ||= User.find(15) # find_by(id: params[:user_id])
    end
  end

  get :status do
    { status: "ok", time: Time.current, version: "v0.1" }
  end

  mount V1::Base
  mount V2::Base

  add_swagger_documentation(
    api_version: "v2",
    info: {
      title: "Tasker API",
      description: "V1 Documentation",
      contact: ""
    },
    security_definitions: {
      api_key: {
        type: "apiKey",
        name: "Authorization",
        in: "header"
      }
    },
    security: [
      {
        api_key: []
      }
    ]
  )
end
