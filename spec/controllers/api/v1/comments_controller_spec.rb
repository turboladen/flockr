require 'spec_helper'

describe Api::V1::CommentsController do
  render_views
  fixtures :users
  fixtures :photos
  fixtures :comments

  let(:valid_attributes) do
    { body: 'The comment body.' }
  end

  let(:user) { users(:guy) }
  let(:photo) { photos(:one) }

  describe "POST 'create'" do
    describe 'with valid params' do
      it 'creates a new Comment' do
        expect {
          post :create, {
            comment: valid_attributes, user_id: user.to_param,
            photo_id: photo.to_param, format: :json
          }
        }.to change(Comment, :count).by(1)
      end

      it 'assigns a newly created comment as @comment' do
        post :create, {
          comment: valid_attributes, user_id: user.to_param,
          photo_id: photo.to_param, format: :json
        }
        assigns(:comment).should be_a(Comment)
        assigns(:comment).should be_persisted
      end

      it 'returns a 201 with the created comment as JSON' do
        post :create, {
          comment: valid_attributes, user_id: user.to_param,
          photo_id: photo.to_param, format: :json
        }
        response.status.should == 201
        body = JSON(response.body)
        body['body'].should == valid_attributes[:body]
      end

      it 'sets the Location header to the API location for the new comment' do
        post :create, {
          comment: valid_attributes, user_id: user.to_param,
          photo_id: photo.to_param, format: :json
        }
        response.status.should == 201
        comment = Comment.last
        response.location.should == api_v1_user_photo_comment_url(user, photo, comment)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved comment as @comment' do
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {
          comment: { body: 'invalid value' }, user_id: user.to_param,
          photo_id: photo.to_param, format: :json
        }

        assigns(:comment).should be_a_new(Comment)
      end

      it 'returns a 422 with errors as JSON' do
        Comment.any_instance.stub(:save).and_return(false)
        post :create, {
          comment: { body: 'invalid value' }, user_id: user.to_param,
          photo_id: photo.to_param, format: :json
        }
        response.status.should == 422
        expect { JSON(response.body) }.to_not raise_exception
      end
    end
  end

  describe 'DELETE destroy' do
    let(:comment) do
      comments(:one)
    end

    it 'destroys the requested comment' do
      expect {
        delete :destroy, {
          id: comment.to_param, user_id: user.to_param,
          photo_id: photo.to_param, format: :json
        }
      }.to change(Comment, :count).by(-1)
    end

    it 'returns a 204 and an empty body' do
      delete :destroy, {
        id: comment.to_param, user_id: user.to_param,
        photo_id: photo.to_param, format: :json
      }
      response.status.should == 204
      response.body.should be_empty
    end
  end
end
