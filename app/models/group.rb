class Group < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true

  belongs_to :user
  has_many :sensors, -> {order('name ASC')}, dependent: :destroy
end