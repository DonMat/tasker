class API < Grape::API
  format :json
  prefix :api

  get :status do
    { status: "ok", time: Time.current }
  end
end
