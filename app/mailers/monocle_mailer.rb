class MonocleMailer < ActionMailer::Base
  default from: "no-reply@phantomdata.com"

  def alarm_triggered_notification(alarm)
  	@sensor = alarm.sensor
  	@user = @sensor.user
  	@subject = "Monocle Alert: #{@sensor.name} triggered an alarm at #{@sensor.last_value}"
  	mail(to: @user.email, subject: @subject)
  end

end
