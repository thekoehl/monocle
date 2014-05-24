module SensorsHelper
  def human_value number
    number.nil? ? 'N/A' : number_to_human_size(number).gsub('B','').gsub('ytes','').gsub('yte','')
  end
end
