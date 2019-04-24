FROM ruby:2.6.1

# for C compiler
RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# configure working directory for all subsequent commands (e.g. RUN etc)
ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# set environment variables
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Install bundler, copy the Gemfile/Gemfile.lock, and install gems
RUN gem install bundler
COPY Gemfile* $APP_HOME/
RUN bundle install

# Add the main application
COPY . $APP_HOME

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
