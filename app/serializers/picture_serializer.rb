class PictureSerializer < ActiveModel::Serializer
  attributes :uuid, :taken_by, :tagged, :image, :caption

  belongs_to :taken_by, serializer: UserSerializer
  belongs_to :tagged, serializer: UserSerializer
  has_many :comments
end
