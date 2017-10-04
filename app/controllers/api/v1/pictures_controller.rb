module Api
  module V1
    class PicturesController < APIController
      def show
        @picture = Picture.find_by_uuid(params[:id])

        if @picture
          render json: @picture
        else
          render json: {error: 'Picture not found'}, status: :bad_request
        end
      end

      def create
        @picture = current_api_user.sent_pictures.new
        @tagged = User.find_by_username(params[:user_id])
        uuid = SecureRandom.uuid

        if !@tagged
          render json: {error: "Username not found"}, status: :bad_request
          return
        end

        image = Paperclip.io_adapters.for(params[:image])
        image.original_filename = "#{uuid}.jpg"

        @picture.uuid = uuid
        @picture.image = image
        @picture.tagged = @tagged
        @picture.caption = params[:caption]

        if @picture.save
          render json: @picture
        else
          render json: {error: @picture.errors}, status: :bad_request
        end
      end

      def update
      end

      def delete
      end

      def like
      end

      def unlike
      end

      def sent
        if params[:user_id] == 'self'
          @user = current_api_user
        else
          @user = User.find_by_username(params[:user_id])
        end

        if @user
          render json: ActiveModel::Serializer::CollectionSerializer.new(@user.sent_pictures)
        else
          render json: {error: 'Username not found'}, status: :bad_request
        end
      end

      def received
        if params[:user_id] == 'self'
          @user = current_api_user
        else
          @user = User.find_by_username(params[:user_id])
        end

        if @user
          render json: ActiveModel::Serializer::CollectionSerializer.new(@user.received_pictures)
        else
          render json: {error: 'Username not found'}, status: :bad_request
        end
      end

      def comment
        @picture = Picture.find_by_uuid(params[:id])
        @comment = @picture.comments.create

        @comment.user = current_api_user
        @comment.comment = params[:comment]

        if @comment.save
          render json: @comment
        else
          render json: {error: @comment.errors}, status: :bad_request
        end
      end

      def comments
        @picture = Picture.find_by_uuid(params[:id])
        render json: ActiveModel::Serializer::CollectionSerializer.new(@picture.comments)
      end

    end
  end
end