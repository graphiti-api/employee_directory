require 'active_record_adapter'

class ApplicationResource < Graphiti::Resource
  self.abstract_class = true
  self.adapter = ActiveRecordAdapter
  self.base_url = Rails.application.routes.default_url_options[:host]
  self.endpoint_namespace = '/api/v1'
end
