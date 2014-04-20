class DataPoint < ActiveRecord::Base

  ################
  # Associations #
  ################
  belongs_to :sensor

  ###############
  # Callbacks   #
  ###############
  after_save :update_last_value_on_sensor
  def update_last_value_on_sensor
    self.sensor.update_attribute(:last_value, self.value)
    self.sensor.check_for_and_trigger_alarm
  end


  ###############
  # Validations #
  ###############
  validates :logged_at, presence: true
  validates :sensor, presence: true
  validates :value, presence: true
  validates :value, numericality: true

end