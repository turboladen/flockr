require 'spec_helper'

describe 'photos/_index.html.erb' do
  let(:photos) do
    [
      stub_model(Photo,
        file_name: 'The File Name',
        image_url: 'Image'
      ),
      stub_model(Photo,
        file_name: 'The File Name',
        image_url: 'Image'
      )
    ]
  end

  let(:user) do
    u = User.new(id: 1, username: 'test', email: 'tester@test.com', password: 'password',
      password_confirmation: 'password')
    u.photos = photos

    u
  end

  it 'renders a list of photos' do
    render partial: 'photos/index', locals: { user: user }

    assert_select 'tr>td', text: 'The File Name', count: 2
    assert_select 'tr>td>a>img', src: '/images/Image', count: 2
  end
end
