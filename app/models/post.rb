class Post
  DATA = [
    { id: 1, title: 'Graphiti' },
    { id: 2, title: 'is' },
    { id: 3, title: 'super' },
    { id: 4, title: 'dope' }
  ]

  def initialize(attrs = {})
    attrs.each_pair { |k,v| send(:"#{k}=", v) }
  end

  ATTRS = [:id, :title]

  ATTRS.each { |a| attr_accessor(a) }

  def attributes
    {}.tap do |attrs|
      ATTRS.each do |name|
        attrs[name] = send(name)
      end
    end
  end
end
