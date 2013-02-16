class ReportingDashboard < ActiveRecord::Base
  # Accessors
  attr_accessible :sensors
  attr_accessible :title

  # Relations
  belongs_to :user
  has_and_belongs_to_many :sensors

end
