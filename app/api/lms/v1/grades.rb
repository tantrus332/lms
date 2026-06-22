module Lms
  module V1
    class Grades < Grape::API
      namespace :courses do
        params do
          requires :course_id, type: Integer
        end
        namespace ":course_id/grades" do
          before do
            @course = Course.find(params[:course_id])
          end

          desc "Список оценок курса (enrolled)"
          get do
            authorize_course_access!(@course)
            @course.grades.map { |g|
              { id: g.id, student_id: g.student_id, course_id: g.course_id, score: g.score, comment: g.comment }
            }
          end

          desc "Выставить оценку (admin или owner teacher)"
          params do
            requires :student_id, type: Integer
            requires :score, type: Integer
            optional :comment, type: String
          end
          post do
            result = Grade::Operations::Create.call(
              params: params,
              course: @course,
              current_user: current_user
            )
            if result.success?
              status 201
              result[:grade]
            else
              error!(result[:grade].errors.full_messages, 422)
            end
          end
        end
      end
    end
  end
end
