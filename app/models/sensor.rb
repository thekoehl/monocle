# == Schema Information
#
# Table name: sensors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  reporter   :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sensor < ActiveRecord::Base
  belongs_to :user
  has_many :alarms
  has_many :data_points

  scope :signal_faulted, where("updated_at <= ?", Time.now - 6.hours)

  validates_presence_of :name

  attr_accessible :name, :reporter

  # Model methods
  def recalculate_maximum_value!
    return unless self.data_points.count > 0
    maximum_value = self.data_points.maximum(:value)
    self.update_attribute('maximum_value', maximum_value)
  end

  def last_value_as_percentage
    if self.maximum_value_recalculated_at.nil? || self.maximum_value_recalculated_at < Time.now-6.hours
      recalculate_maximum_value!
    end

    return 0 unless self.data_points.count > 0
    return 0 unless self.maximum_value > 0

    datapoint = self.data_points.last
    return ( (datapoint.value.to_f / self.maximum_value.to_f) * 100).to_i
  end

  def signal_faulted
    self.updated_at < (Time.now-6.hours)
  end

  # Average computations
  def average_by_hour
    self.data_points.average(:value, :group => "created_at_hourly", :order => "created_at ASC", 
                               :conditions => ["created_at >= ?", Time.now - 48.hours])
  end
  def average_by_day
      self.data_points.average(:value, :group => "created_at_daily", :order => "created_at ASC")
  end
  def average_by_month
    self.data_points.average(:value, :group => "created_at_monthly", :order => "created_at ASC")
  end

  def todays_average
 		DataPoint.average(:value, :conditions => ["sensor_id = ? AND created_at > ?", self.id, Time.now-24.hours]).to_i
  end
  def yesterdays_average
  	DataPoint.average(:value, :conditions => ["sensor_id = ? AND created_at > ? AND created_at < ?", self.id, Time.now-48.hours, Time.now-24.hours]).to_i
  end
end
