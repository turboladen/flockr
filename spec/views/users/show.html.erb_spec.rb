require 'spec_helper'

describe 'users/show' do
  before(:each) do
    @user = assign(:user, stub_model(User,
      username: 'Username', created_at: Time.now
    ))
  end

  it 'renders attributes in <p>' do
    render

    rendered.should match(/Username/)
  end
end
