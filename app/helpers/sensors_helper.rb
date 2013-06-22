module SensorsHelper
  # Expects a data_set like:
  # [
  #    [[1,a], [2,b], 3,c]],
  #    [[1,a], 3,c]]
  # ]
  # Trims out items without keys in both sets (in this case [2,b])
  def cleanup_dataset data_set
    keys_to_delete = get_incomplete_keys data_set

    return data_set if keys_to_delete.length == 0

    data_set.each do |data_group|
      data_group.delete_if do |i|
        keys_to_delete.include?(i[0])
      end
    end

    return data_set
  end

private

  def get_incomplete_keys data_set
    keys_to_delete = []

    data_set.each do |data_group|
      data_group.each do |data_point|
        keys_to_delete << data_point[0] unless key_in_all_groups data_set, data_point[0]
      end
    end
    return keys_to_delete
  end

  def key_in_all_groups data_set, key
    key_present_in_all = true
    data_set.each do |data_group|
      key_present_in_all = false unless key_in_data_group? data_group, key
    end
    return key_present_in_all
  end

  def key_in_data_group? data_group, key
    data_group.each do |data_point|
      return true if data_point[0] == key
    end

    return false

  end
end
