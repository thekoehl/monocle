class UserMailer < ActionMailer::Base
  default from: "noreply@phantomdata.com"

  def send_alarm_notification(user, alarm, data_point_value)
    @user = user
    @alarm = alarm
    @data_point_value = data_point_value
    subject = "[Monocle] #{@alarm.sensor.name} is experiencing a #{@alarm.trigger_type} value @ #{@data_point_value}#{@alarm.units}!"

    mail(:to => user.email, :subject => subject).deliver!
  end
end
