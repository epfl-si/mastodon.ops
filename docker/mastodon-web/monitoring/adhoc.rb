# As per https://github.com/discourse/prometheus_exporter?tab=readme-ov-file#global-metrics-in-a-custom-type-collector

unless defined? Rails
  require File.expand_path("../../config/environment", __FILE__)
end

class MastodonAdHocCollector < PrometheusExporter::Server::TypeCollector
  def type
    "unused, yet required by the superclass for some reason?"
  end

  def metrics
    # Count users
    user_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_user_count', 'Number of Mastodon users')
    user_count_gauge.observe User.count

    # Count all statuses
    status_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_status_count', 'Number of Mastodon statuses')
    status_count_gauge.observe Status.count

    # Count local statuses
    local_status_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_local_status_count', 'Number of Mastodon local statuses')
    local_status_count_gauge.observe Status.where(local: true).count

    # Counting boosts (repost)
    boost_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_boost_count', 'Number of Mastodon boosts')
    boost_count_gauge.observe Status.where.not(reblog_of_id: nil).count

    # Counting boosts of local statuses
    local_boost_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_local_boost_count', 'Number of Mastodon local boosts')
    local_boost_count_gauge.observe Status.joins('JOIN statuses as original_statuses ON statuses.reblog_of_id = original_statuses.id')
                                          .where('original_statuses.local': true)
                                          .count

    # Counting favourites (likes)
    favourite_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_favourite_count', 'Number of Mastodon favourites')
    favourite_count_gauge.observe Favourite.count

    # Count local favourites
    local_favourite_count_gauge = PrometheusExporter::Metric::Gauge.new('mastodon_local_favourite_count', 'Number of Mastodon local favourites')
    local_favourite_count_gauge.observe Favourite.joins(:status)
                                                 .where(statuses: { local: true })
                                                 .count

    [
      user_count_gauge,
      status_count_gauge,
      local_status_count_gauge,
      boost_count_gauge,
      local_boost_count_gauge,
      favourite_count_gauge,
      local_favourite_count_gauge
    ]
  end
end
