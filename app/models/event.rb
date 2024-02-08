class Event
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :id,          :string
  attribute :name,        :string
  attribute :description, :string
  attribute :notify,      :boolean, default: false

  alias :notify? :notify
end

