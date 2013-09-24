require 'spec_helper'

describe 'photos/show' do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      file_name: 'File Name',
      image_url: 'http://test'
    ))
  end

  it 'renders attributes in <p>' do
    render

    rendered.should match(/File Name/)
    rendered.should match(%r[http://test])
  end
end
