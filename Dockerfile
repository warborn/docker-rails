FROM ruby:2.7

LABEL maintainer="ivanalejandro249@gmail.com"

RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  build-essential \
  nodejs \
  yarn

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install
RUN bundle exec rails webpacker:install

COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
