module Lms
  module V1
    class Auth < Grape::API
      namespace :auth do
        desc "Регистрация"
        params do
          requires :username, type: String
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
        end
        post :register do
          user = User.new(
            username: params[:username],
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation],
            role: :student
          )
          if user.save
            token = JsonWebToken.encode(user_id: user.id)
            { token: token, user: { id: user.id, username: user.username, email: user.email, role: user.role } }
          else
            error!(user.errors.full_messages, 422)
          end
        end

        desc "Логин"
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post :login do
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: user.id)
            { token: token, user: { id: user.id, username: user.username, email: user.email, role: user.role } }
          else
            error!("Неверный email или пароль", 401)
          end
        end
      end
    end
  end
end
