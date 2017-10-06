class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :received_pictures, :class_name => 'Picture', :foreign_key => 'tagged_id'
  has_many :sent_pictures, :class_name => 'Picture', :foreign_key => 'taken_by_id'

  validates :name, presence: true
  validates :username, presence: true

  acts_as_follower
  acts_as_followable
end
