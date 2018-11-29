require 'rails_helper'

RSpec.feature 'Switch User' do
  let(:user_attributes) do
    { email: 'test@example.com' }
  end
  let(:user) do
    User.new(user_attributes) { |u| u.save(validate: false) }
  end

  before do
    login_as user
  end

  scenario 'Non-admin user is not allowed to see switch user form' do
    visit '/users/sessions/log_in_as'
    expect(page).to have_no_selector('select')
  end

  scenario 'Admin user is allowed to see switch user form' do
    admin = Role.where(name: 'admin').first_or_create
    admin.users << user
    visit '/users/sessions/log_in_as'
    expect(page).to have_css('select#switch_user_identifier')
  end
end
