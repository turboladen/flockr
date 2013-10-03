require 'spec_helper'

describe Api::V1::PhotosController do
  describe 'routing' do
    it 'routes to #index' do
      get('/api/v1/users/1/photos').should route_to(controller: 'api/v1/photos',
        user_id: '1', action: 'index', format: 'json')
    end

    it 'routes to #show' do
      get('/api/v1/users/1/photos/2').should route_to(controller: 'api/v1/photos',
        user_id: '1', id: '2', action: 'show', format: 'json')
    end

    it 'routes to #create' do
      post('/api/v1/users/1/photos').should route_to(controller: 'api/v1/photos',
        user_id: '1', action: 'create', format: 'json')
    end

    it 'routes to #update' do
      put('/api/v1/users/1/photos/2').should route_to(controller: 'api/v1/photos',
        user_id: '1', id: '2', action: 'update', format: 'json')
    end

    it 'routes to #destroy' do
      delete('/api/v1/users/1/photos/2').should route_to(controller: 'api/v1/photos',
        user_id: '1', id: '2', action: 'destroy', format: 'json')
    end
  end
end
