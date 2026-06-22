# frozen_string_literal: true

module Lms
  module V1
    class Base < Grape::API
      version "v1", using: :path

      helpers do
        def current_user
          @current_user
        end

        # парсим токен из заголовка Authorization
        def authenticate!
          token = request.headers["Authorization"]&.split(" ")&.last
          payload = JsonWebToken.decode(token)
          @current_user = User.find_by(id: payload[:user_id]) if payload
          error!("Необходима авторизация", 401) unless @current_user
        end

        def admin!
          error!("Доступ запрещён", 403) unless current_user.admin?
        end

        def authorize_user!(user)
          error!("Доступ запрещён", 403) unless current_user.admin? || current_user.id == user.id
        end

        def authorize_course_owner!(course)
          error!("Доступ запрещён", 403) unless current_user.admin? || course.owner_id == current_user.id
        end

        # проверяем: админ владелец курса или студент курса
        def authorize_course_access!(course)
          return if current_user.admin?
          return if course.owner_id == current_user.id
          return if course.course_students.exists?(user_id: current_user.id)
          error!("Доступ запрещён", 403)
        end
      end

      # пропускаем auth для логина и сваггера
      before do
        unless request.path.match?(%r{/auth/}) ||
               request.path.match?(%r{/swagger_doc})
          authenticate!
        end
      end

      mount Lms::V1::Auth
      mount Lms::V1::Users
      mount Lms::V1::Courses
      mount Lms::V1::CourseStudents
      mount Lms::V1::Grades

      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/swagger_doc",
        info: {
          title: "LMS API",
          description: "Система управления обучением API"
        },
        security_definitions: {
          Bearer: {
            type: "apiKey",
            name: "Authorization",
            in: "header"
          }
        },
        security: [{ Bearer: [] }]
      )
    end
  end
end
