module Chargify2
  class Event < Representation
    property :id
    property :key
    property :message
    property :subscription_id
    property :event_specific_data
    property :created_at
  end
end

