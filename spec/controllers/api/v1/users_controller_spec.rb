require 'spec_helper'

describe Api::V1::UsersController do
  render_views
  fixtures :users

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      email: 'MyString',
      username: 'MyString',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:user) { users(:guy) }

  describe 'GET index' do
    it 'assigns all users as @users' do
      get :index, format: :json
      assigns(:users).should eq([users(:admin), users(:guy)])
    end
  end

  describe 'GET show' do
    it 'assigns the requested user as @user' do
      get :show, { id: user.to_param, format: :json }
      assigns(:user).should eq(user)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, { user: valid_attributes, format: :json }
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes, format: :json }
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it 'returns a 201 with the created user as JSON' do
        post :create, { user: valid_attributes, format: :json }
        response.status.should == 201
        body = JSON(response.body)
        body['email'].should == valid_attributes[:email].downcase
      end

      it 'sets the Location header to the API location for the new user' do
        post :create, { user: valid_attributes, format: :json }
        response.status.should == 201
        response.location.should == api_v1_user_url(User.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, { user: {
          email: 'invalid value', username: 'invalid_value', format: :json
        }}
        assigns(:user).should be_a_new(User)
      end

      it 'returns a 422 with the errors as JSON' do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {
          user: {
            email: 'invalid value', username: 'invalid_value', format: :json
          }
        }
        response.status.should == 422
        expect { JSON(response.body) }.to_not raise_exception
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested user' do
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update).with({ 'email' => 'MyString' })
        put :update, { id: user.to_param, user: { email: 'MyString' } }
      end

      it 'assigns the requested user as @user' do
        put :update, { id: user.to_param, user: valid_attributes, format: :json }
        assigns(:user).should eq(user)
      end

      it 'returns a 204 with an empty body' do
        put :update, { id: user.to_param, user: valid_attributes, format: :json }
        response.status.should == 204
        response.body.should be_empty
      end
    end

    describe 'with invalid params' do
      before do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, { id: user.to_param, user: { email: 'invalid value' }, format: :json }
      end

      it 'assigns the user as @user' do
        assigns(:user).should eq(user)
      end

      it 'returns a 422 with the errors as JSON' do
        response.status.should == 422
        expect { JSON(response.body) }.to_not raise_exception
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested user' do
      expect {
        delete :destroy, { id: user.to_param, format: :json }
      }.to change(User, :count).by(-1)
    end

    it 'returns a 204 with an empty body' do
      delete :destroy, { id: user.to_param, format: :json }
      response.status.should == 204
      response.body.should be_empty
    end
  end
end
