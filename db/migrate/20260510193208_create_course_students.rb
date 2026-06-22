class CreateCourseStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :course_students do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :role, null: false, default: 1

      t.timestamps
    end

    add_index :course_students, [:user_id, :course_id], unique: true
  end
end
