module Lms
  module V1
    class Users < Grape::API
      namespace :users do
        desc "Список всех пользователей (только admin)"
        get do
          admin!
          User.all.map { |u| { id: u.id, username: u.username, email: u.email, role: u.role } }
        end

      end
    end
  end
end
