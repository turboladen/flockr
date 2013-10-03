require 'spec_helper'

describe Api::V1::CommentsController do
  describe 'routing' do
    it 'routes to #create' do
      post('/api/v1/users/1/photos/2/comments').should route_to(controller: 'api/v1/comments',
        user_id: '1', photo_id: '2', action: 'create', format: 'json')
    end

    it 'routes to #update' do
      put('/api/v1/users/1/photos/2/comments/3').should route_to(controller: 'api/v1/comments',
        user_id: '1', photo_id: '2', id: '3', action: 'update', format: 'json')
    end

    it 'routes to #destroy' do
      delete('/api/v1/users/1/photos/2/comments/3').should route_to(controller: 'api/v1/comments',
        user_id: '1', photo_id: '2', id: '3', action: 'destroy', format: 'json')
    end
  end
end
