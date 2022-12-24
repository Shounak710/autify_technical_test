FROM ruby:2.7.2
WORKDIR /usr/src/autify_test/
ADD . .
RUN bundle install
EXPOSE 3333
ENTRYPOINT ["ruby", "/usr/src/autify_test/fetch.rb"]