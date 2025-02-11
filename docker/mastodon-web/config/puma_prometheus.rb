
on_worker_boot do
  require 'prometheus_exporter/instrumentation'
  PrometheusExporter::Instrumentation::Process.start(type: "web")
  PrometheusExporter::Instrumentation::ActiveRecord.start(
    custom_labels: { type: "web" })
end

after_worker_boot do
  require 'prometheus_exporter/instrumentation'
  if !PrometheusExporter::Instrumentation::Puma.started?
    PrometheusExporter::Instrumentation::Puma.start
  end
end
