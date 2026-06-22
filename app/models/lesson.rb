# class Lesson < ApplicationRecord
#   belongs_to :course
#
#   validates :title, presence: true
#   validates :content, presence: true
#   # порядок урока в курсе
#   validates :position, numericality: { greater_than_or_equal_to: 0 }
# end
