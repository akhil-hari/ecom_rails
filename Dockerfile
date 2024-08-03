ARG RUBY_VERSION=3.2.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim AS base

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  curl \
  libxml2-dev \
  libxslt1-dev \
  libmariadb-dev-compat \
  libmariadb-dev

# Set the working directory
WORKDIR /ecom_rails

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /ecom_rails/Gemfile
COPY Gemfile.lock /ecom_rails/Gemfile.lock

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . /ecom_rails

# Install Yarn (for Webpacker)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Install node_modules
RUN yarn install --check-files

# Expose the port the app runs on
EXPOSE 3000

# Add a script to be executed every time the container starts
ENTRYPOINT ["./entrypoint.sh"]

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]

