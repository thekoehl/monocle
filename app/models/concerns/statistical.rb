module Statistical
  extend ActiveSupport::Concern

  included do
  end
  
  def maximum
    return @maximum if @maximum
    return 0 if self.data_points.length == 0
    
    @maximum = self.data_points.maximum(:value)
    return @maximum
  end

  def minimum
    return @minimum if @minimum
    return 0 if self.data_points.length == 0
    
    @minimum = self.data_points.minimum(:value)
    return @minimum
  end

  def average
    return @average if @average
    return 0 if self.data_points.length == 0

    @average = self.data_points.average(:value)
    return @average
  end

  def current_percentage
    return @current_percentage if @current_percentage
    return 0 if self.current_value == 0 || self.maximum == 0
    
    @current_percentage = ((self.current_value / self.maximum) * 100).to_i
    return @current_percentage
  end

  def current_value
    return @current_value if @current_value
    return 0 if self.data_points.length == 0
    
    @current_value = self.last_data_point.value
    return @current_value
  end

end
