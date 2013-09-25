require 'spec_helper'

describe CommentsController do
  fixtures :users
  fixtures :photos
  fixtures :comments

  let(:valid_attributes) do
    { body: 'The comment body.' }
  end

  let(:valid_session) { {} }
  let(:user) { users(:guy) }
  let(:photo) { photos(:one) }

  describe "GET 'new'" do
    it 'assigns a new comment as @comment' do
      get 'new', { user_id: user.to_param, photo_id: photo.to_param }, valid_session
      assigns(:comment).should be_a_new Comment
    end
  end

  describe "POST 'create'" do
    describe 'with valid params' do
      it 'creates a new Comment' do
        expect {
          post :create, {
            comment: valid_attributes, user_id: user.to_param, photo_id: photo.to_param
          }, valid_session
        }.to change(Comment, :count).by(1)
      end

      it 'assigns a newly created comment as @comment' do
        post :create, {
          comment: valid_attributes, user_id: user.to_param, photo_id: photo.to_param
        }, valid_session
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it 'redirects to the created photo' do
        post :create, {
          comment: valid_attributes, user_id: user.to_param, photo_id: photo.to_param
        }, valid_session
        response.should redirect_to(user_photo_path(user, photo))
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved comment as @comment' do
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {
          comment: { body: 'invalid value' }, user_id: user.to_param, photo_id: photo.to_param
        }, valid_session

        assigns(:comment).should be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {
          comment: { body: 'invalid value' }, user_id: user.to_param, photo_id: photo.to_param
        }, valid_session
        response.should render_template('new')
      end
    end
  end

  describe "GET 'destroy'" do
    let(:comment) do
      comments(:one)
    end

    describe 'DELETE destroy' do
      it 'destroys the requested comment' do
        expect {
          delete :destroy, { id: comment.to_param, user_id: user.to_param, photo_id: photo.to_param },
            valid_session
        }.to change(Comment, :count).by(-1)
      end

      it 'redirects to the photo' do
        delete :destroy, { id: comment.to_param, user_id: user.to_param, photo_id: photo.to_param },
          valid_session
        response.should redirect_to(user_photo_url(user, photo))
      end
    end
  end
end
