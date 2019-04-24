Rails.application.routes.draw do
  get "/health_check", to: "health#index"
end
