require 'spec_helper'

describe 'photos/show' do
  let(:photo) do
    stub_model(Photo,
      file_name: 'File Name',
      image_url: 'http://test'
    )
  end

  let(:user) do
    stub_model(User,
      username: 'Username',
      email: 'Email',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  before do
    assign(:photo, photo)
  end

  it 'renders attributes in <p>' do
    render

    rendered.should match(/File Name/)
    rendered.should match(%r[http://test])
  end

  context 'no comments' do
    it 'does not show any comments' do
      render

      rendered.should match %r[No comments.]
    end
  end

  context 'with comments' do
    let(:comments) do
      [
        stub_model(Comment, body: 'First comment', updated_at: Time.now, user: user),
        stub_model(Comment, body: 'Second comment', updated_at: Time.now, user: user)
      ]
    end

    before do
      allow(photo).to receive(:comments) { comments }
    end

    it 'shows the comments and who left each comment' do
      render

      rendered.should match %r[Username]
      rendered.should match %r[First comment]
      rendered.should match %r[Second comment]
    end

    context 'current user left the comment' do
      before do
        view.stub(:current_user).and_return user
      end

      it 'has an edit link on the comment' do
        render

        rendered.should have_link 'Edit', edit_user_photo_comment_path(user, photo, comments.first)
      end

      it 'has an delete link on the comment' do
        render

        rendered.should have_link 'Delete', user_photo_comment_path(user, photo, comments.first)
      end
    end

    context 'current user did not leave the comment' do
      before do
        view.stub(:current_user).and_return 'not the user'
      end

      it 'has an edit link on the comment' do
        render

        rendered.should_not have_link 'Edit', edit_user_photo_comment_path(user, photo, comments.first)
      end

      it 'has an delete link on the comment' do
        render

        rendered.should_not have_link 'Delete', user_photo_comment_path(user, photo, comments.first)
      end
    end
  end

  it 'includes a link to leave a comment' do
    render

    rendered.should have_link 'Leave a comment',
      new_user_photo_comment_path(user, photo)
  end
end
