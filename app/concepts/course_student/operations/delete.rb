module CourseStudent
  module Operations
    class Delete < Trailblazer::Operation
      step :find_course_student
      step :authorize!
      step :destroy

      def find_course_student(ctx, params:, course:, **)
        ctx[:course_student] = course.course_students.find(params[:id])
      end

      def authorize!(ctx, course_student:, course:, current_user:, **)
        current_user.admin? ||
          course.owner_id == current_user.id ||
          course_student.user_id == current_user.id
      end

      def destroy(ctx, course_student:, **)
        course_student.destroy!
      end
    end
  end
end
