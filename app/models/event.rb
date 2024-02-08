class Event
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :id,          :string
  attribute :name,        :string
  attribute :description, :string
end

