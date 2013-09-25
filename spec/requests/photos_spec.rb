require 'spec_helper'

describe 'Photos' do
  fixtures :users

  describe 'GET /photos' do
    it 'works! (now write some real specs)' do
      user = users(:guy)

      get user_photos_path(user)
      response.status.should be(302)
    end
  end
end
