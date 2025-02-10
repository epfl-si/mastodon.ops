FROM ghcr.io/mastodon/mastodon:v4.3.3

USER root
RUN echo "gem 'prometheus_exporter'" >> Gemfile
RUN bundle config unset frozen && bundle install


COPY config/initializers/prometheus_exporter.rb config/initializers/
COPY config/puma_prometheus.rb /tmp/puma_prometheus.rb
RUN cat /tmp/puma_prometheus.rb >> config/puma.rb && rm /tmp/puma_prometheus.rb

USER mastodon

