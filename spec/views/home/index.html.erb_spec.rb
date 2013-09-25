require 'spec_helper'

describe 'home/index.html.erb' do
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

  before do
    assign(:photos, Kaminari.paginate_array(photos).page(1))
  end

  it 'renders a list of photos' do
    render

    assert_select 'tr>td>p>a>img', src: '/images/Image', count: 4
    assert_select 'tr>td>p', text: 'The File Name', count: 4
  end
end
