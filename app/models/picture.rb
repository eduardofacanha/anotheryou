class Picture < ApplicationRecord

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_commentable

  belongs_to :taken_by, :class_name => 'User'
  belongs_to :tagged, :class_name => 'User'

  validates :image, attachment_presence: true
  validates :taken_by, presence: true
  validates :tagged, presence: true

end
