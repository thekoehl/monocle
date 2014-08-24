module Alarmable
  extend ActiveSupport::Concern

  included do
  end

  FLAPPING_DELAY = 60 * 60 * 6

  def check_for_and_trigger_alarm
    return if !self.last_notification_sent_at.nil? && (Time.now - self.last_notification_sent_at) <= FLAPPING_DELAY

    ['high_level', 'low_level', 'signal_fault'].each do |type|
      next unless self.send("#{type}_active?".to_sym)
      Event.new(event_type: type, sensor_id: self.id).save!
      notify_of_active_alarm type
      self.update_attributes({last_notification_sent_at: Time.now, needs_attention: true})
    end
  end

private

  def notify_of_active_alarm type
    MonocleMailer.alarm_email(self, type).deliver!
  end

  def signal_fault_active?
    return false if self.data_points.count == 0
    return false if self.signal_fault_delay.nil?

    # Signal fault delay is expressed in hours, so multiply by 60 for minutes and another for seconds
    return (Time.now - self.last_data_point.logged_at) > self.signal_fault_delay * 3600
  end

  def low_level_active?
    return false if self.low_level.nil? || self.last_value.nil?
    return self.last_value <= self.low_level
  end

  def high_level_active?
    return false if self.high_level.nil? || self.last_value.nil?
    return self.last_value >= self.high_level
  end

end