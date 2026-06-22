FROM ruby:4.0.5-alpine

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    yaml-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
