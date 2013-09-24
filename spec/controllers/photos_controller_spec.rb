require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PhotosController do
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

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PhotosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:user) do
    users(:guy)
  end

  let(:photo) { photos(:one) }

  describe 'GET index' do
    it 'assigns all photos as @photos' do
      get :index, { user_id: user.to_param }, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe 'GET show' do
    it 'assigns the requested photo as @photo' do
      get :show, { id: photo.to_param, user_id: user.to_param }, valid_session
      assigns(:photo).should eq(photo)
    end
  end

  describe 'GET new' do
    it 'assigns a new photo as @photo' do
      get :new, { user_id: user.to_param }, valid_session
      assigns(:photo).should be_a_new(Photo)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested photo as @photo' do
      get :edit, { id: photo.to_param, user_id: user.to_param }, valid_session
      assigns(:photo).should eq(photo)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Photo' do
        expect {
          post :create, { photo: valid_attributes, user_id: user.to_param }, valid_session
        }.to change(Photo, :count).by(1)
      end

      it 'assigns a newly created photo as @photo' do
        post :create, { photo: valid_attributes, user_id: user.to_param }, valid_session
        assigns(:photo).should be_a(Photo)
        assigns(:photo).should be_persisted
      end

      it 'redirects to the created photo' do
        post :create, { photo: valid_attributes, user_id: user.to_param }, valid_session
        response.should redirect_to(user_photo_path(user, Photo.last))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved photo as @photo' do
        # Trigger the behavior that occurs when invalid params are submitted
        Photo.any_instance.stub(:save).and_return(false)
        post :create, { photo: { file_name: 'invalid value' }, user_id: user.to_param },
          valid_session
        assigns(:photo).should be_a_new(Photo)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Photo.any_instance.stub(:save).and_return(false)
        post :create, { photo: { file_name: 'invalid value' }, user_id: user.to_param },
          valid_session
        response.should render_template('new')
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
        put :update, { id: photo.to_param, photo: { file_name: 'MyString' }, user_id: user.to_param },
          valid_session
      end

      it 'assigns the requested photo as @photo' do
        put :update, { id: photo.to_param, photo: valid_attributes, user_id: user.to_param },
          valid_session
        assigns(:photo).should eq(photo)
      end

      it 'redirects to the photo' do
        put :update, { id: photo.to_param, photo: valid_attributes, user_id: user.to_param },
          valid_session
        response.should redirect_to(user_photo_path(user, photo))
      end
    end

    describe 'with invalid params' do
      before do
        # Trigger the behavior that occurs when invalid params are submitted
        Photo.any_instance.stub(:save).and_return(false)
        put :update, { id: photo.to_param, photo: { file_name: 'invalid value' }, user_id: user.to_param },
          valid_session
      end

      it 'assigns the photo as @photo' do
        assigns(:photo).should eq(photo)
      end

      it "re-renders the 'edit' template" do
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested photo' do
      expect {
        delete :destroy, { id: photo.to_param, user_id: user.to_param },
          valid_session
      }.to change(Photo, :count).by(-1)
    end

    it 'redirects to the photos list' do
      delete :destroy, { id: photo.to_param, user_id: user.to_param },
        valid_session
      response.should redirect_to(user_photos_url(user))
    end
  end
end
