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

  after_save :check_for_and_trigger_alarms_if_needed
  def check_for_and_trigger_alarms_if_needed
    self.sensor.alarms.each do |alarm|
      alarm.check_for_and_trigger_if_needed
    end

    return true
  end

  before_validation :compute_statistical_references
  def compute_statistical_references
    tn = Time.now.in_time_zone(Rails.configuration.time_zone)

    self.monthly_segmentation = tn.strftime("%Y/%m")
    self.daily_segmentation   = tn.strftime("%a %m/%d")
    self.hourly_segmentation  = tn.strftime("%a %m/%d %H:00")

    return true
  end
end
