class AppellationSerializer < ActiveModel::Serializer
  attributes :id, :name, :region
  has_one :region
end
