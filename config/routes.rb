require_relative "../app/api/lms/v1/base"

Rails.application.routes.draw do
  mount Lms::V1::Base, at: "/api"

  get "up" => "rails/health#show", as: :rails_health_check
  get "swagger" => redirect("/swagger.html")
end
