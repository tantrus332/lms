puts "Заполнение базы данных..."

admin = User.find_or_create_by!(email: "admin@test.com") do |u|
  u.username = "admin"
  u.password = "password123"
  u.role = :admin
end

teacher1 = User.find_or_create_by!(email: "teacher1@test.com") do |u|
  u.username = "teacher1"
  u.password = "password123"
  u.role = :teacher
end

teacher2 = User.find_or_create_by!(email: "teacher2@test.com") do |u|
  u.username = "teacher2"
  u.password = "password123"
  u.role = :teacher
end

student1 = User.find_or_create_by!(email: "student1@test.com") do |u|
  u.username = "student1"
  u.password = "password123"
  u.role = :student
end

student2 = User.find_or_create_by!(email: "student2@test.com") do |u|
  u.username = "student2"
  u.password = "password123"
  u.role = :student
end

puts "Пользователи: #{User.count}"

course1 = Course.find_or_create_by!(title: "Математика") do |c|
  c.description = "Основы программирования"
  c.owner = teacher1
end

course2 = Course.find_or_create_by!(title: "Информатика") do |c|
  c.description = "Программирование и алгоритмы"
  c.owner = teacher2
end

puts "Курсы: #{Course.count}"

CourseStudent.find_or_create_by!(user: student1, course: course1) do |e|
  e.role = :student
end

CourseStudent.find_or_create_by!(user: student2, course: course2) do |e|
  e.role = :student
end

CourseStudent.find_or_create_by!(user: student1, course: course2) do |e|
  e.role = :student
end

puts "Записи на курс: #{CourseStudent.count}"

Grade.find_or_create_by!(student: student1, course: course1) do |g|
  g.score = 85
  g.comment = "Хорошие результаты"
end

Grade.find_or_create_by!(student: student1, course: course2) do |g|
  g.score = 90
  g.comment = "Отлично"
end

Grade.find_or_create_by!(student: student2, course: course2) do |g|
  g.score = 75
  g.comment = "Нужна доработка"
end

puts "Оценки: #{Grade.count}"
puts "Готово!"
