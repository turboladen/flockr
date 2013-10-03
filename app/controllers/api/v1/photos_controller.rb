class Api::V1::PhotosController < ApiController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /photos.json
  def index
  end

  # GET /photos/1.json
  def show
  end

  # POST /photos.json
  def create
    @photo = @user.photos.new(photo_params)

    if @photo.save
      render action: 'show', status: :created, location: api_v1_user_photo_url(@photo.user, @photo)
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1.json
  def update
    if @photo.update(photo_params)
      head :no_content
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    head :no_content
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
