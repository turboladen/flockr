require 'spec_helper'


feature 'Authentication' do
  scenario 'New user signs up' do
    visit '/sign_up'

    fill_in 'Username', with: 'some_guy'
    fill_in 'Email', with: 'guy@people.org'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'

    expect {
      click_button 'Sign Up'
    }.to change { User.count }.by 1
  end
end
