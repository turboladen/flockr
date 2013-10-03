require 'spec_helper'


describe Api::V1::PhotosController do
  render_views
  fixtures :users
  fixtures :photos

  # This should return the minimal set of attributes required to create a valid
  # Photo. As you add validations to Photo, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      file_name: 'MyString',
      user_id: user.id,
      image: 'the image'
    }
  end

  let(:user) do
    users(:guy)
  end

  let(:photo) { photos(:one) }

  describe 'GET index' do
    it 'assigns all photos as @photos' do
      get :index, { user_id: user.to_param, format: :json }
      assigns(:user).should eq(user)
    end
  end

  describe 'GET show' do
    it 'assigns the requested photo as @photo' do
      get :show, { id: photo.to_param, user_id: user.to_param, format: :json }
      assigns(:photo).should eq(photo)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Photo' do
        expect {
          post :create, {
            photo: valid_attributes, user_id: user.to_param, format: :json
          }
        }.to change(Photo, :count).by(1)
      end

      it 'assigns a newly created photo as @photo' do
        post :create, {
          photo: valid_attributes, user_id: user.to_param, format: :json
        }
        assigns(:photo).should be_a(Photo)
        assigns(:photo).should be_persisted
      end

      it 'returns a 201 with the created photo as JSON' do
        post :create, {
          photo: valid_attributes, user_id: user.to_param, format: :json
        }
        response.status.should == 201
        body = JSON(response.body)
        body['file_name'].should == valid_attributes[:file_name]
      end

      it 'sets the Location header to the API location for the new photo' do
        post :create, {
          photo: valid_attributes, user_id: user.to_param, format: :json
        }
        response.status.should == 201
        photo = Photo.last
        response.location.should == api_v1_user_photo_url(photo.user, photo)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved photo as @photo' do
        # Trigger the behavior that occurs when invalid params are submitted
        Photo.any_instance.stub(:save).and_return(false)
        post :create, {
          photo: { file_name: 'invalid value' },
          user_id: user.to_param, format: :json
        }
        assigns(:photo).should be_a_new(Photo)
      end

      it 'reutrns a 422 with the errors as JSON' do
        # Trigger the behavior that occurs when invalid params are submitted
        Photo.any_instance.stub(:save).and_return(false)
        post :create, {
          photo: { file_name: 'invalid value' },
          user_id: user.to_param, format: :json
        }
        response.status.should == 422
        expect { JSON(response.body) }.to_not raise_exception
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested photo' do
        # Assuming there are no other photos in the database, this
        # specifies that the Photo created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Photo.any_instance.should_receive(:update).with({ 'file_name' => 'MyString' })
        put :update, {
          id: photo.to_param, photo: { file_name: 'MyString' },
          user_id: user.to_param, format: :json
        }
      end

      it 'assigns the requested photo as @photo' do
        put :update, {
          id: photo.to_param, photo: valid_attributes, user_id: user.to_param,
          format: :json
        }
        assigns(:photo).should eq(photo)
      end

      it 'returns a 204 with an empty body' do
        put :update, {
          id: photo.to_param, photo: valid_attributes, user_id: user.to_param,
          format: :json
        }
        response.status.should == 204
        response.body.should be_empty
      end
    end

    describe 'with invalid params' do
      before do
        # Trigger the behavior that occurs when invalid params are submitted
        Photo.any_instance.stub(:save).and_return(false)
        put :update, {
          id: photo.to_param, photo: { file_name: 'invalid value' },
          user_id: user.to_param, format: :json
        }
      end

      it 'assigns the photo as @photo' do
        assigns(:photo).should eq(photo)
      end

      it 'returns a 422 with the errors as JSON' do
        response.status.should == 422
        expect { JSON(response.body) }.to_not raise_exception
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested photo' do
      expect {
        delete :destroy, {
          id: photo.to_param, user_id: user.to_param, format: :json
        }
      }.to change(Photo, :count).by(-1)
    end

    it 'returns a 204 with an empty body' do
      delete :destroy, {
        id: photo.to_param, user_id: user.to_param, format: :json
      }
      response.status.should == 204
      response.body.should be_empty
    end
  end
end
