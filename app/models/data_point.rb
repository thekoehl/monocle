class DataPoint < ActiveRecord::Base
  validates :logged_at, presence: true
  validates :sensor, presence: true
  validates :value, presence: true
  validates :value, numericality: true

  belongs_to :sensor
end