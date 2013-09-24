require 'spec_helper'

describe 'photos/new' do
  before(:each) do
    assign(:photo, stub_model(Photo,
      file_name: 'name to my pic',
      path: 'path to my pic'
    ).as_new_record)

    assign(:user, stub_model(User,
      id: 1,
      username: 'MyUsername',
      email: 'MyString@email.com'
    ))
  end

  it 'renders new photo form' do
    render

    assert_select 'form[action=?][method=?]', "#{user_photos_path(user_id: 1)}/", 'post' do
      assert_select 'input#photo_file_name[name=?]', 'photo[file_name]'
      assert_select 'input#photo_image[name=?]', 'photo[image]'
    end
  end
end
