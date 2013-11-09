class DataPoint < ActiveRecord::Base

  #################
  # Relationships #
  #################

  belongs_to :sensor

  ##########
  # Scopes #
  ##########
  scope :segmented, ->(segmentation) {
     group("#{segmentation}_segmentation")
    .order("#{segmentation}_segmentation")
  }

  ###############
  # Validations #
  ###############

  validates :hourly_segmentation, presence: true
  validates :daily_segmentation, presence: true
  validates :monthly_segmentation, presence: true
  validates :value, presence: true

  ##################
  # Action Filters #
  ##################

  before_validation :compute_statistical_references
  def compute_statistical_references
    tn = Time.now.utc.in_time_zone(ActiveSupport::TimeZone["Central Time (US & Canada)"])
    self.monthly_segmentation = tn.strftime("%Y/%m")
    self.daily_segmentation   = tn.strftime("%a %m/%d")
    self.hourly_segmentation  = tn.strftime("%a %m/%d %H:00")

    return true
  end
end
