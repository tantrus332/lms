module Lms
  module V1
    class CourseStudents < Grape::API
      namespace :courses do
        params do
          requires :course_id, type: Integer
        end
        namespace ":course_id/course_students" do
          before do
            @course = Course.find(params[:course_id])
          end

          desc "Записать пользователя на курс (админ или владелец преподаватель)"
          params do
            requires :user_id, type: Integer
            optional :role, type: String, default: "student"
          end
          post do
            authorize_course_owner!(@course)
            course_student = @course.course_students.new(
              user_id: params[:user_id],
              role: params[:role]
            )
            if course_student.save
              status 201
              { id: course_student.id, user_id: course_student.user_id, course_id: course_student.course_id, role: course_student.role }
            else
              error!(course_student.errors.full_messages, 422)
            end
          end

          desc "Отчислить с курса (админ, владелец преподаватель или сам студент)"
          params do
            requires :id, type: Integer
          end
          delete ":id" do
            result = CourseStudent::Operations::Delete.call(
              params: params,
              course: @course,
              current_user: current_user
            )
            if result.success?
              { message: "Запись удалена" }
            else
              error!("Доступ запрещён", 403)
            end
          end
        end
      end
    end
  end
end
