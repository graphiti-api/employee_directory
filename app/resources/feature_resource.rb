class FeatureResource < TaskResource
  attribute :points, :integer do
    rand(20)
  end
end
