# == Schema Information
#
# Table name: data_points
#
#  id                 :integer          not null, primary key
#  value              :integer
#  reporter           :string(255)
#  sensor_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  units              :string(255)
#  created_at_monthly :string(255)
#  created_at_hourly  :string(255)
#  created_at_daily   :string(255)
#

class DataPoint < ActiveRecord::Base
  attr_accessible :reporter, :units, :value
  
  after_create :update_parent_updated_at
  after_create :check_for_and_trigger_alarms

  before_create :compute_statistical_references

  belongs_to :sensor

  scope :ordered_by_latest, order('created_at DESC')

  validates_presence_of :reporter
  validates_presence_of :sensor
  validates_presence_of :units
  validates_presence_of :value

  def compute_statistical_references
  	tn = Time.now.utc.in_time_zone(ActiveSupport::TimeZone["Central Time (US & Canada)"])
	  self.created_at_monthly = tn.strftime("%Y/%m")
	  self.created_at_daily = tn.strftime("%a %m/%d")
	  self.created_at_hourly = tn.strftime("%a %m/%d %H:00")
  end
  
  def check_for_and_trigger_alarms
    self.sensor.alarms.each do |alarm|
      alarm.check_for_and_trigger self.value
    end
  end

  def update_parent_updated_at
    self.sensor.updated_at = Time.now + 6.hours
    self.sensor.save!
  end
end
