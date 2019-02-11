class POROAdapter < Graphiti::Adapters::Abstract
  def base_scope(*)
    { sort: {}, filters: {}, db: nil }
  end

  def paginate(scope, current, per)
    scope.merge!(current_page: current, per_page: per)
  end

  def order(scope, att, dir)
    scope[:sort].merge!(attribute: att, direction: dir)
    scope
  end

  def self.default_operators
    {
      string: [:eq],
      integer: [:eq]
    }
  end

  def filter(scope, attribute, value)
    scope[:filters][attribute] = value
    scope
  end
  alias :filter_string_eq :filter
  alias :filter_integer_eq :filter

  def transaction(*)
    yield
  end

  def destroy(model)
    Post::DATA.reject! { |d| d[:id].to_s == model.id.to_s }
    model
  end

  def save(model)
    attrs = model.attributes.dup
    attrs[:id] ||= Post::DATA.length + 1
    if existing = Post::DATA.find { |d| d[:id].to_s == attrs[:id].to_s }
      existing.merge!(attrs)
    else
      Post::DATA << attrs
    end
    model
  end

  def resolve(scope)
    data  = scope[:db]

    if sort = scope[:sort].presence
      data = data.sort_by { |d| d[sort[:attribute].to_sym] }
      data = data.reverse if sort[:direction] == :desc
    end

    scope[:filters].each_pair do |k, v|
      data = data.select { |d| d[k.to_sym].in?(v) }
    end

    start = (scope[:current_page] - 1) * scope[:per_page]
    stop  = start + scope[:per_page]
    data  = data[start...stop]

    data.map { |d| resource.model.new(d) }
  end
end

class PostResource < Graphiti::Resource
  self.adapter = POROAdapter
  self.endpoint_namespace = '/api/v1'

  attribute :title, :string

  def base_scope
    super.merge(db: Post::DATA)
  end

  #def build(model_class)
    #model_class.new
  #end

  #def assign_attributes(model, attributes)
    #attributes.each_pair do |k, v|
      #model.send(:"#{k}=", v)
    #end
  #end

  #def save(model)
    #attrs = model.attributes.dup
    #attrs[:id] ||= Post::DATA.length + 1
    #if existing = Post::DATA.find { |d| d[:id].to_s == attrs[:id].to_s }
      #existing.merge!(attrs)
    #else
      #Post::DATA << attrs
    #end
    #model
  #end

  #def delete(model)
    #Post::DATA.reject! { |d| d[:id].to_s == model.id.to_s }
    #model
  #end
end
