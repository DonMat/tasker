class API < Grape::API
  logger.formatter = GrapeLogging::Formatters::Default.new
  use GrapeLogging::Middleware::RequestLogger, logger: logger, include: [
    GrapeLogging::Loggers::FilterParameters.new
  ]

  format :json
  content_type :json, "application/json; charset=utf-8"
  prefix :api

  get :status do
    { status: "ok", time: Time.current }
  end
end
