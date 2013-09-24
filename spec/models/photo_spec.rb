require 'spec_helper'

describe Photo do
  it { should respond_to :user }
  it { should respond_to :image }
  it { should respond_to :comments }

  subject do
    Photo.new(file_name: 'test.file')
  end

  describe 'file_name' do
    it 'is required' do
      expect(Photo.new.errors_on(:file_name)).to include "can't be blank"
    end
  end

  it 'can belong to a user' do
    user = User.new(username: 'test', email: 'test@test.com', password: 'password',
      password_confirmation: 'password')
    subject.user = user
    subject.should be_valid
  end
end
