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

  def edit
    @comment = @photo.comments.find(params[:id])
  end

  def update
    @comment = @photo.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_photo_path(@user, @photo), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    respond_to do |format|
      format.html { redirect_to user_photo_url(@user, @photo) }
      format.json { head :no_content }
    end
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
