require 'spec_helper'


describe User do
  describe 'email' do
    context 'when not provided' do
      it 'fails validation' do
        expect(User.new).to have(1).error_on(:email)
      end
    end

    context 'with a duplicate' do
      it 'fails validation' do
        User.create!(username: 'test', email: 'test@test.com')
        expect(User.new(email: 'test@test.com')).to have(1).error_on(:email)
      end
    end

    context 'when created as upcased' do
      it 'saves the address as lowercase' do
        user = User.create!(username: 'test', email: 'TEST@Test.com')
        expect(user.email).to eq 'test@test.com'
      end
    end
  end

  describe 'username' do
    context 'when not provided' do
      it 'fails validation' do
        expect(User.new).to have(1).error_on(:username)
      end
    end

    context 'when a duplicate' do
      it 'fails validation' do
        User.create!(username: 'test', email: 'test@test.com')
        expect(User.new(username: 'test')).to have(1).error_on(:username)
      end
    end

    context 'when created as upcased' do
      it 'saves the username as lowercase' do
        user = User.create!(username: 'TeSt', email: 'test@test.com')
        expect(user.username).to eq 'test'
      end
    end
  end

  describe 'photos' do
    it 'can have many photos' do
      user = User.new(email: 'test@test.com', username: 'test')
      2.times { user.photos << Photo.new }
      expect(user).to be_valid
      user.save!
    end
  end

  describe '#destroy' do
    it 'destroys associated photos' do
      photo = Photo.new
      user = User.create!(email: 'test@test.com', username: 'test', photos: [photo])

      expect { user.destroy }.to change { Photo.count }.by -1
    end
  end
end
