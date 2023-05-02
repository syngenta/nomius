FROM ruby:3.2.2
LABEL maintainer="Oleksii Leonov <oleksii.leonov@syngenta.com>"

RUN bundle config --global without development test

WORKDIR /usr/src/app

COPY . .
RUN bundle install

ENTRYPOINT ["bundle", "exec", "nomius"]
