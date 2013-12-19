class DataPoint < ActiveRecord::Base

  #################
  # Relationships #
  #################

  belongs_to :numeric_sensor

  ##########
  # Scopes #
  ##########
  scope :segmented, ->(segmentation) {
     group("#{segmentation}_segmentation")
    .order("#{segmentation}_segmentation")
  }
  scope :closest_to, ->(datetime) {
    where('created_at >= ? AND created_at <= ?', datetime-15.minutes, datetime+15.minutes)
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
    self.numeric_sensor.alarms.each do |alarm|
      alarm.check_for_and_trigger_if_needed
    end

    return true
  end

  before_validation :compute_statistical_references
  def compute_statistical_references
    tn = Time.now.in_time_zone(Rails.configuration.time_zone)

    self.hourly_segmentation  = tn.strftime("%Y/%m/%d %H:00 (%a)")
    self.daily_segmentation   = tn.strftime("%Y/%m/%d (%a)")
    self.monthly_segmentation = tn.strftime("%Y/%m")

    return true
  end

  ####################
  # Instance Methods #
  ####################

  def closest_data_point datetime
    data_points = self.numeric_sensor.data_points.closest_to(datetime)
    return DataPoint.new(created_at: datetime, value: 0) if data_points.count == 0
    return data_points.first
  end

end
