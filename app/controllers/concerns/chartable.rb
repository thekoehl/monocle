module Chartable
  extend ActiveSupport::Concern

  def chart_data
    return @sensor.data_points.send("group_by_#{chart_detail_options[0]}", :logged_at, range: chart_range).maximum(:value)
  end

  def chart_range
    return (chart_detail_options[1]..chart_end_date)
  end

  def chart_end_date
    return Time.now if @sensor.nil? || @sensor.last_data_point.nil?
    return @sensor.last_data_point.logged_at
  end

  # Returns the resolution and how far back to send the chart.
  def chart_detail_options
    if params[:timespan].nil? || params[:timespan] == 'day' then
      return ['hour', 1.days.ago.midnight]
    elsif params[:timespan] == 'week'
      return ['hour', 7.days.ago.midnight]
    elsif params[:timespan] == 'month'
      return ['day', 31.days.ago.midnight]
    elsif params[:timespan] == 'year'
      return ['day', 365.days.ago.midnight]
    end
  end

end