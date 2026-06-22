class CourseStudent < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum :role, { teacher: 0, student: 1 }

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :course_id }
end
