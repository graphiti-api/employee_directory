type = Dry::Types['strict.string']

Graphiti::Types[:uuid] = {
  params: type,
  read: type,
  write: type,
  kind: 'scalar',
  canonical_name: :uuid,
  description: 'For UUIDs'
}

class ActiveRecordAdapter < Graphiti::Adapters::ActiveRecord
  alias :filter_uuid_eq :filter_string_eql
end
