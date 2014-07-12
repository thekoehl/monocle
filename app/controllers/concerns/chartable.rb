module Chartable
  extend ActiveSupport::Concern

  MAX_LABELS = 12

  def x_axis_labels
    mapped = chart_data.map{|k,v| k}
    mod = mapped.length / MAX_LABELS
    labels = mapped.select.with_index{|_,i| (i+1) % mod == 0}
    labels << mapped.last unless labels.last == mapped.last
    return condense_labels labels
  end

  def values
    mapped = chart_data.map{|k,v| v}
    mod = mapped.length / MAX_LABELS
    values = mapped.select.with_index{|_,i| (i+1) % mod == 0}
    values << mapped.last
    return condense_values values
  end

  def condense_labels labels
    if params[:timespan].nil? || params[:timespan] == 'day' || params[:timespan] == 'week' then
      return labels.map {|v| v.strftime('%a %H:%M') }
    elsif params[:timespan] == 'month' || params[:timespan] == 'year'
      return labels.map {|v| v.strftime('%m/%d/%Y')}
    end
  end

  def condense_values values
    max = values.max
    return values if max < 1024
    scaler = 0
    while ( (max/scaler) > 1024 ) do
      scaler += 1024
    end
    return values.map {|v| (v / scaler).to_i}
  end

  # OLD

  def chart_data
    return @chart_data if @chart_data
    @chart_data = @sensor.data_points.send("group_by_#{chart_detail_options[0]}", :logged_at, range: chart_range).maximum(:value)
    return @chart_data
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
      return ['hour', 24.hours.ago]
    elsif params[:timespan] == 'week'
      return ['hour', 7.days.ago.midnight]
    elsif params[:timespan] == 'month'
      return ['day', 31.days.ago.midnight]
    elsif params[:timespan] == 'year'
      return ['day', 365.days.ago.midnight]
    end
  end

end
