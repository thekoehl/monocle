class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #################
  # Relationships #
  #################

  has_many :alarms
  has_many :cameras, dependent: :destroy
  has_many :camera_events, dependent: :destroy
  has_many :sensors, dependent: :destroy

  ###############
  # Validations #
  ###############

  validates :api_key, presence: true

  ##################
  # Action Filters #
  ##################
  before_validation :generate_and_assign_api_key, if: Proc.new {|p| p.api_key.nil? || p.api_key = ""}
  def generate_and_assign_api_key
    self.api_key = SecureRandom.uuid
  end

end
