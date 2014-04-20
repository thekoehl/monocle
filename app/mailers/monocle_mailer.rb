class MonocleMailer < ActionMailer::Base
  default from: ENV['GMAIL_USERNAME']
  def alarm_email(sensor, type)
    @user = sensor.group.user
    @sensor = sensor
    mail(to: @user.email, subject: "MONOCLE: #{@sensor.name} is experiencing a #{type} alarm at #{@sensor.last_value}")
  end
end