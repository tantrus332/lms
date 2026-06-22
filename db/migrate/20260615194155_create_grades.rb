class CreateGrades < ActiveRecord::Migration[8.1]
  def change
    create_table :grades do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true
      t.integer :score, null: false
      t.text :comment

      t.timestamps
    end

    add_index :grades, [:student_id, :course_id], unique: true
  end
end
