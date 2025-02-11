# As per https://github.com/discourse/prometheus_exporter?tab=readme-ov-file#global-metrics-in-a-custom-type-collector

unless defined? Rails
  require File.expand_path("../../config/environment", __FILE__)
end

class MastodonAdHocCollector < PrometheusExporter::Server::TypeCollector
  def type
    "unused, yet required by the superclass for some reason?"
  end

  def metrics
    user_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_user_count', 'Number of Mastodon users')
    user_count_gauge.observe User.count
    [user_count_gauge]
  end
end
