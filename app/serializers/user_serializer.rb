class UserSerializer < ActiveModel::Serializer
  attributes :name, :username, :bio, :followers_count, :following_count

  def followers_count
    object.followers_count
  end

  def following_count
    object.follow_count
  end
end
