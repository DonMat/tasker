Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*" # , 'http://localhost', 'http://localhost:3000', 'http://localhost:8080', 'http://localhost:4040'
    resource "*",
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[current-page page-items total-pages total-count]
  end
end
