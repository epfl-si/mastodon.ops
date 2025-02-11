
on_worker_boot do
  require 'prometheus_exporter/instrumentation'
  PrometheusExporter::Instrumentation::Process.start(type: "web")
  PrometheusExporter::Instrumentation::ActiveRecord.start(
    custom_labels: { type: "web" })
end
