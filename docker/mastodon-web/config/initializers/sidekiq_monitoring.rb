Sidekiq.configure_server do |config|
  config.on :startup do
    require 'prometheus_exporter/instrumentation'
    PrometheusExporter::Instrumentation::ActiveRecord.start(
      custom_labels: { type: "sidekiq" })
    PrometheusExporter::Instrumentation::Process.start type: 'sidekiq'
    PrometheusExporter::Instrumentation::SidekiqProcess.start
    PrometheusExporter::Instrumentation::SidekiqQueue.start
    PrometheusExporter::Instrumentation::SidekiqStats.start
  end
end
