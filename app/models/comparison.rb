class Comparison < ActiveRecord::Base
  # Accessors
  attr_accessible :sensors
  attr_accessible :title

  # Relations
  belongs_to :user
  has_and_belongs_to_many :sensors

  # Validations
  validate :must_have_at_least_one_sensor
  validates_presence_of :title
private
  def must_have_at_least_one_sensor
  	if sensors.blank?
  		errors.add(:sensors, "You must select at least one sensor.")
  	end
  end
end
