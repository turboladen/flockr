require 'spec_helper'

describe Comment do
  it { should respond_to :body }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }
  it { should respond_to :user }
  it { should respond_to :photo }

  describe 'body' do
    it 'is required' do
      expect(Comment.new.errors_on(:body)).to include "can't be blank"
    end
  end

  describe 'user' do
    it 'is required' do
      expect(Comment.new.errors_on(:user)).to include "can't be blank"
    end
  end

  describe 'photo' do
    it 'is required' do
      expect(Comment.new.errors_on(:photo)).to include "can't be blank"
    end
  end
end
