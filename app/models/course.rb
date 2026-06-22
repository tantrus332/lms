class Course < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :course_students, dependent: :destroy
  has_many :enrolled_users, through: :course_students, source: :user
  has_many :grades, dependent: :destroy

  validates :title, presence: true
end
