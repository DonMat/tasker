class API < Grape::API
  version "v1", "v2", "v3", using: :path

  # logger.formatter = GrapeLogging::Formatters::Default.new
  # use GrapeLogging::Middleware::RequestLogger, logger: logger, include: [
  #   GrapeLogging::Loggers::FilterParameters.new
  # ]

  format :json
  content_type :json, "application/json; charset=utf-8"
  prefix :api

  helpers do
    def current_user
      @current_user ||= User.first # For testing and benchmarking purposes
    end
  end

  get :status do
    { status: "ok", time: Time.current, version: "v0.1" }
  end

  mount V1::Base
  mount V2::Base
  mount V3::Base

  add_swagger_documentation(
    api_version: "v3",
    info: {
      title: "Tasker API",
      description: "V3 Documentation",
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
