FROM ghcr.io/mastodon/mastodon:v4.5.7

USER root
RUN bundle config unset frozen && bundle install

COPY config/initializers/*.rb config/initializers/
COPY monitoring/ monitoring/
COPY config/puma_prometheus.rb /tmp/puma_prometheus.rb
RUN cat /tmp/puma_prometheus.rb >> config/puma.rb && rm /tmp/puma_prometheus.rb

USER mastodon
