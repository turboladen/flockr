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

  scenario 'Existing user signs in' do
    visit '/sign_in'

    expect(page).to have_title 'Sign in'
    expect(page).to have_field 'Username'
    expect(page).to have_field 'Password'
    expect(page).to have_button 'Sign in'
  end
end
