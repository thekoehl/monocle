class DataPoint < ActiveRecord::Base
  attr_accessible :reporter, :units, :value
  before_create :compute_statistical_references
  belongs_to :sensor

  validates_presence_of :reporter
  validates_presence_of :sensor
  validates_presence_of :units
  validates_presence_of :value

  def compute_statistical_references
  	tn = Time.now.utc
	  self.created_at_monthly = tn.strftime("%Y/%m")
	  self.created_at_daily = tn.strftime("%Y/%m/%d")
	  self.created_at_hourly = tn.strftime("%Y/%m/%d %H:00")
  end
end