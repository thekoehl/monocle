module Alarmable
  extend ActiveSupport::Concern

  included do
  end

  FLAPPING_DELAY = 60 * 60 * 6

  def check_for_and_trigger_alarm
    return if !self.last_notification_sent_at.nil? && (Time.now - self.last_notification_sent_at) <= FLAPPING_DELAY

    ['high_level', 'low_level', 'signal_fault'].each do |type|
      next unless self.send("#{type}_active?".to_sym)
      notify_of_active_alarm type
      self.update_attribute(last_notification_sent_at: Time.now)
    end
  end

private

  def notify_of_active_alarm type
    #LoggerService.instance.log_error "#{type} alarm encountered for #{@human_name} at #{value}"
  end

  def signal_fault_active?
    return false if self.data_points.count == 0
    return false if self.signal_fault_delay.nil?

    # Signal fault delay is expressed in hours, so multiply by 60
    return (Time.now - self.data_points.order('logged_at DESC').last.logged_at) > self.signal_fault_delay * 60
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