class Grade < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :course

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :student_id, uniqueness: { scope: :course_id }
end
