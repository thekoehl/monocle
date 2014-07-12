module ApplicationHelper
  def number_to_human_size_agnostic number
    number_to_human_size(number).gsub('Bytes','').gsub('B', '')
  end
end
