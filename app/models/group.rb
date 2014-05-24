class Group < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true

  belongs_to :user
  has_many :sensors, -> {order('name ASC')}, dependent: :destroy

  # Why not just use sensors.any(needs_attention: true)?  The context of this method
  # is meant to be in a group setting.  You should pre-fetch the sensors with:
  #      groups.includes(:sensors)
  def needs_attention?
    sensors.find {|s| return true if s.needs_attention }
    return false
  end
end
