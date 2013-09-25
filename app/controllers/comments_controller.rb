class CommentsController < ApplicationController
  before_action :set_photo
  before_action :set_user

  def new
    @comment = @photo.comments.new
  end

  def create
    params_with_user = comment_params.merge(user: @user)
    @comment = @photo.comments.new(params_with_user)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@user, @photo], notice: 'Comment was successfully added.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html do
          flash.now[:alert] = @comment.errors.full_messages
          render action: 'new'
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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
