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
    user = User.create!(email: 'guy@people.org', username: 'some_guy',
      password: 'password', password_confirmation: 'password')
    visit '/sign_in'

    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content user.username
    expect(page).to have_link 'Sign Out', href: '/sign_out'
    expect(page).to_not have_link 'Sign In', href: '/sign_in'
  end
end
