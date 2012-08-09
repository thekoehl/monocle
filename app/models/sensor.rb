class Sensor < ActiveRecord::Base
    belongs_to :user
    has_many :data_points

    validates_presence_of :name

    attr_accessible :name, :reporter

    def average_by_hour
        self.data_points.average(:value, :group => "created_at_hourly", :order => "created_at ASC")
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