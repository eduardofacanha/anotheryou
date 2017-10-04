module Api
  module V1
    class UsersController < APIController
      def show

        if params[:id] == 'self'
          @user = current_api_user
        else
          @user = User.find_by_username(params[:id])
        end

        render json: @user
      end

      def followers
        render json: ActiveModel::Serializer::CollectionSerializer.new(current_api_user.user_followers)
      end

      def following
        render json: ActiveModel::Serializer::CollectionSerializer.new(current_api_user.following_users)
      end

      def relationship
        @user = User.find_by_username(params[:id])

        if @user
          render json: {
            follower: current_api_user.followed_by?(@user),
            following: current_api_user.following?(@user)
          }
        else
          render json: {error: 'Username not found'}, status: :bad_request
        end

      end

      def follow
        @user = User.find_by_username(params[:id])

        if @user
          current_api_user.follow(@user)
          render json: {success: true}
        else
          render json: {error: 'Username not found'}, status: :bad_request
        end
      end

      def unfollow
        @user = User.find_by_username(params[:id])

        if @user
          current_api_user.stop_following(@user)
          render json: {success: true}
        else
          render json: {error: 'Username not found'}, status: :bad_request
        end
      end
    end
  end
end