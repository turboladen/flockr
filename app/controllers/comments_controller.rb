class CommentsController < ApplicationController
  before_action :set_photo
  before_action :set_user
  respond_to :html

  def new
    @comment = @photo.comments.new
  end

  def create
    params_with_user = comment_params.merge(user: @user)
    @comment = @photo.comments.new(params_with_user)

    if @comment.save
      redirect_to [@user, @photo], notice: 'Comment was successfully added.'
    else
      flash.now[:alert] = @comment.errors.full_messages
      render action: 'new'
    end
  end

  def edit
    @comment = @photo.comments.find(params[:id])
  end

  def update
    @comment = @photo.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to user_photo_path(@user, @photo), notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    redirect_to user_photo_url(@user, @photo)
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
