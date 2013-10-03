class Api::V1::CommentsController < ApplicationController
  before_action :set_user
  before_action :set_photo
  before_action :set_comment, only: %i[show update]
  respond_to :json

  def create
    params_with_user = comment_params.merge(user: @user)
    @comment = @photo.comments.new(params_with_user)

    if @comment.save
      render action: 'show', status: :created,
        location: api_v1_user_photo_comment_url(@user, @photo, @comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @comment.update(comment_params)
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    head :no_content
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_comment
    @comment = @photo.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
