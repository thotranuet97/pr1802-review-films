require 'rails_helper'

feature "password resets" do
  scenario "resets password when valid email is provided" do
    user = create :user

    visit login_path
    click_link t "sessions.new.reset_password"
    fill_in id: "email", with: user.email
    click_button t "password_resets.new.reset_password"
    expect(current_path).to eq root_path
    expect(page).to have_content(
      t "password_resets.create.email_sent_if_valid")
    expect(last_email.to).to include user.email

    open_email user.email
    visit_in_email t "user_mailer.password_reset.reset_password"
    fill_in id: "password", with: "12345678"
    fill_in id: "password_confirmation", with: "12345678"
    click_button t "password_resets.edit.update_pass"
    expect(current_path).to eq root_path
    expect(page).to have_content(
      t "password_resets.update.password_has_been_reset")

    visit login_path
    fill_in id: "email", with: user.email
    fill_in id: "password", with: "12345678"
    click_button t "sessions.new.login_btn_title"
    expect(page).to have_content t "layouts.client.header.logout"
  end

  scenario "does not email invalid user" do
    visit login_path
    click_link t "sessions.new.reset_password"
    fill_in id: "email", with: "wrongemailaaaa@gmail.com"
    click_button t "password_resets.new.reset_password"
    expect(current_path).to eq root_path
    expect(page).to have_content(
      t "password_resets.create.email_sent_if_valid")
    expect(last_email).to be_nil
  end
end
