require 'spec_helper'

describe 'Photos' do
  describe 'GET /photos' do
    it 'works! (now write some real specs)' do
      user = User.first || User.create(email: 'test@test.com', username: 'test',
        password: 'password', password_confirmation: 'password')

      get user_photos_path(user)
      response.status.should be(302)
    end
  end
end
