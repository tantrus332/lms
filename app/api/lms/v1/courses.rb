module Lms
  module V1
    class Courses < Grape::API
      namespace :courses do
        desc "Список курсов (фильтрация по роли)"
        get do
          courses = case current_user.role
            when "admin"   then Course.all
            when "teacher" then current_user.owned_courses
            when "student" then current_user.enrolled_courses
          end
          courses.map { |c| { id: c.id, title: c.title, description: c.description, owner_id: c.owner_id } }
        end

        desc "Создать курс (admin или teacher)"
        params do
          requires :title, type: String
          optional :description, type: String
        end
        post do
          admin! unless current_user.teacher?
          course = Course.new(title: params[:title], description: params[:description], owner: current_user)
          if course.save
            status 201
            { id: course.id, title: course.title, description: course.description, owner_id: course.owner_id }
          else
            error!(course.errors.full_messages, 422)
          end
        end

        desc "Получить курс по ID"
        params do
          requires :id, type: Integer
        end
        get ":id" do
          course = Course.find(params[:id])
          authorize_course_access!(course)
          { id: course.id, title: course.title, description: course.description, owner_id: course.owner_id }
        end

        desc "Удалить курс"
        params do
          requires :id, type: Integer
        end
        delete ":id" do
          course = Course.find(params[:id])
          authorize_course_owner!(course)
          course.destroy!
          { message: "Курс удалён" }
        end
      end
    end
  end
end
