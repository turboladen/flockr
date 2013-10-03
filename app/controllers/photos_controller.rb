class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  respond_to :html

  # GET /photos
  def index
    redirect_to user_path(@user)
  end

  # GET /photos/1
  def show
  end

  # GET /photos/new
  def new
    @photo = @user.photos.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  def create
    @photo = @user.photos.new(photo_params)

    if @photo.save
      redirect_to user_photo_path(@user, @photo), notice: 'Photo was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      redirect_to user_photo_path(@user, @photo), notice: 'Photo was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
    redirect_to user_photos_url(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:file_name, :path, :user_id, :image)
    end
end
