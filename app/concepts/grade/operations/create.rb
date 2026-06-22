module Grade
  module Operations
    class Create < Trailblazer::Operation
      step :authorize!
      step :create_grade

      def authorize!(ctx, course:, current_user:, **)
        current_user.admin? || course.owner_id == current_user.id
      end

      def create_grade(ctx, course:, params:, **)
        ctx[:grade] = course.grades.create(
          student_id: params[:student_id],
          score: params[:score],
          comment: params[:comment]
        )
        ctx[:grade].persisted?
      end
    end
  end
end
