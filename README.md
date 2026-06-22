# LMS

Learning Management System - система управления обучением.

## Модели

- User - пользователь (admin, teacher, student)
- Course - курс
- CourseStudent - запись на курс
- Grade - оценка

## Запуск

```bash
docker compose up --build -d
docker compose exec app bin/rails db:create db:migrate db:seed
```

http://localhost:3001
