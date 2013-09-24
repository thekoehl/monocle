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

  has_and_belongs_to_many :comparisons
  before_destroy { comparisons.clear }

  belongs_to :user
  has_many :alarms
  has_many :data_points, dependent: :destroy

  scope :signal_faulted, where("updated_at <= ?", Time.now - 6.hours)

  validates_presence_of :name

  attr_accessible :name, :reporter, :group_name, :minimum_value, :maximum_value, :minimum_value_recalculated_at, :maximum_value_recalculated_at

  # Instance methods

  def group_name_sortable
    return "Undefined" if self.group_name.nil?
    return self.group_name
  end

  def recalculate_minimum_value!
    unless self.minimum_value_recalculated_at.nil? || self.minimum_value_recalculated_at < Time.now-6.hours
      return
    end
    return unless self.data_points.count > 0

    minimum_value = self.data_points.minimum(:value)
    self.update_attributes({minimum_value: minimum_value, minimum_value_recalculated_at: Time.now})
  end

  def recalculate_maximum_value!
    unless self.maximum_value_recalculated_at.nil? || self.maximum_value_recalculated_at < Time.now-6.hours
      return
    end
    return unless self.data_points.count > 0
    maximum_value = self.data_points.maximum(:value)
    self.update_attributes(maximum_value: maximum_value, maximum_value_recalculated_at: Time.now)
  end

  def last_value_as_percentage
    recalculate_minimum_value!
    recalculate_maximum_value!


    return 0 unless self.data_points.count > 0
    return 0 unless self.maximum_value > 0

    datapoint = self.data_points.last
    max = self.maximum_value.to_f
    min = self.minimum_value.to_f
    val = datapoint.value.to_f

    range = max - min

    return 0 if range == 0

    return (  100 * ( (val - min) / range )  ).to_i
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
