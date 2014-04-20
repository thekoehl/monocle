class Event < ActiveRecord::Base
  belongs_to :sensor
  validates :event_type, presence: true
  validates :sensor, presence: true
end