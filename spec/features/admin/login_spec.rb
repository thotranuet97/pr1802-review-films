require 'rails_helper'

feature "admin_login" do
  scenario "login with admin permission" do
    user = build :user
    user.admin = true
    user.save

    visit login_path
    fill_in id: "email", with: user.email
    fill_in id: "password", with: user.password
    click_button t "sessions.new.login_btn_title"
    expect(page).to have_content t "layouts.client.header.logout"

    visit admin_path
    expect(page).to have_content t "layouts.admin.header.review_admin"
  end

  scenario "does not access admin with no admin access" do
    user = create :user

    visit login_path
    fill_in id: "email", with: user.email
    fill_in id: "password", with: user.password
    click_button t "sessions.new.login_btn_title"
    expect(page).to have_content t "layouts.client.header.logout"

    visit admin_path
    expect(current_path).to eq root_path
    expect(page).to have_content t "admin.unauthorized"
  end
end
