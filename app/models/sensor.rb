class Sensor < ActiveRecord::Base
  belongs_to :user
  has_many :alarms
  has_many :data_points

  scope :signal_faulted, where("updated_at <= ?", Time.now - 6.hours)

  validates_presence_of :name

  attr_accessible :name, :reporter

  # Model methods
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
    self.data_points.average(:value, :group => "created_at_monthly", :order => "created_at ASC",
          :conditions => ["created_at >= ?", Time.now - 3.months])
  end

  def todays_average
 		DataPoint.average(:value, :conditions => ["sensor_id = ? AND created_at > ?", self.id, Time.now-24.hours]).to_i
  end
  def yesterdays_average
  	DataPoint.average(:value, :conditions => ["sensor_id = ? AND created_at > ? AND created_at < ?", self.id, Time.now-48.hours, Time.now-24.hours]).to_i
  end
end