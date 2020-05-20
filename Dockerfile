FROM phusion/passenger-ruby25

ENV HOME /root

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && mkdir -p /home/app/webapp \
  && chown -R app:app /home/app

# specific to the phusion/passenger images
# enable nginx and phusion
RUN rm -f /etc/service/nginx/down

# setup nginx
COPY config/nginx.conf /etc/nginx/sites-enabled/default

WORKDIR /home/app/webapp

COPY --chown=app:app Gemfile Gemfile.lock ./
COPY --chown=app:app gemfiles/* ./gemfiles/

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1 \
  && bundle install

COPY --chown=app:app . .
