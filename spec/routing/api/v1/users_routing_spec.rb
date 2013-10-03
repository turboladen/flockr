require 'spec_helper'

describe Api::V1::UsersController do
  describe 'routing' do
    it 'routes to #index' do
      get('/api/v1/users').should route_to(controller: 'api/v1/users',
        action: 'index', format: 'json')
    end

    it 'routes to #show' do
      get('/api/v1/users/1').should route_to(controller: 'api/v1/users',
        action: 'show', format: 'json', id: '1')
    end

    it 'routes to #create' do
      post('/api/v1/users').should route_to(controller: 'api/v1/users',
        action: 'create', format: 'json')
    end

    it 'routes to #update' do
      put('/api/v1/users/1').should route_to(controller: 'api/v1/users',
        action: 'update', format: 'json', id: '1')
    end

    it 'routes to #destroy' do
      delete('/api/v1/users/1').should route_to(controller: 'api/v1/users',
        action: 'destroy', format: 'json', id: '1')
    end
  end
end
