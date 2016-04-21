require 'rails_helper'
RSpec.describe 'updating user' do
  it 'updates user and redirects to profile page' do
    user = create_user
    log_in user
    expect(page).to have_text('henry')
    click_link 'Edit Profile'
    fill_in 'Name', with: 'drake'
    click_button 'Update'
    expect(page).not_to have_text('henry')
    expect(page).to have_text('drake')
    puts "Update test completed"
  end
end