class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 0, teacher: 1, student: 2 }

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  has_many :owned_courses, class_name: "Course", foreign_key: :owner_id, dependent: :destroy
  has_many :course_students, dependent: :destroy
  has_many :enrolled_courses, through: :course_students, source: :course
  has_many :grades, foreign_key: :student_id, dependent: :destroy
end
