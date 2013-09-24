require 'spec_helper'

describe SessionsController do
  fixtures :users

  describe "GET 'new'" do
    it 'returns http success' do
      get :new
      response.should be_success
    end

    it 'renders the new template' do
      get :new
      response.should render_template 'new'
    end
  end

  describe "POST 'create'" do
    let(:user) do
      users(:guy)
    end

    context 'when good password given' do
      it "redirects to the user's page" do
        post :create, { session: { username: user.username, password: 'password' } }
        response.should redirect_to user
      end
    end

    context 'when bad password given' do
      it 'rerenders the login page and displays the error' do
        post :create, { session: { username: user.username, password: 'MEOW' } }
        response.should render_template('new')
        flash[:error].should == 'Invalid username/password combination'
      end
    end
  end

  describe "DELETE 'destroy'" do
    it 'redirects to the root url' do
      delete :destroy
      response.should redirect_to root_url
    end

    it 'signs out the current user' do
      controller.should_receive :sign_out
      delete :destroy
    end
  end
end
