require 'spec_helper'

describe HomeController do
  fixtures :photos

  describe "GET 'index'" do
    it 'assigns all photos as @photos' do
      get 'index'
      assigns(:photos).should_not be_empty
      assigns(:photos).first.should be_a Photo
    end
  end
end
