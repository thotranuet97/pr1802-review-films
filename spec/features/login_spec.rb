require 'rails_helper'

feature "login" do
  scenario "login when valid credentials are provided" do
    user = create :user

    visit login_path
    fill_in id: "email", with: user.email
    fill_in id: "password", with: user.password
    click_button t "sessions.new.login_btn_title"
    expect(page).to have_content t "layouts.client.header.logout"
  end

  scenario "does not login with wrong credentials" do
    user = create :user

    visit login_path
    fill_in id: "email", with: user.email
    fill_in id: "password", with: "wrongpass1234"
    click_button t "sessions.new.login_btn_title"
    expect(page).to have_content t "sessions.create.invalid_email_password"
  end
end
