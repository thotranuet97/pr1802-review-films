require "rails_helper"

RSpec.describe User, type: :model do
  let (:user) {build :user}

  it "is a valid user" do
    expect(user).to be_valid
  end

  it "does not have a name" do
    user.name = ""
    user.valid?
    expect(user.errors[:name]).to include(
      t "activerecord.errors.messages.blank"
    )
  end

  it "has a short name" do
    user.name = "1"
    user.valid?
    expect(user.errors[:name]).to include(
      t "activerecord.errors.messages.too_short",
        count: Settings.user.name.length.minimum
    )
  end

  it "has no email address" do
    user.email = ""
    user.valid?
    expect(user.errors[:email]).to include(
      t "activerecord.errors.messages.blank"
    )
  end

  it "has a wrong-format email address" do
    user.email = "a"
    user.valid?
    expect(user.errors[:email]).to include(
      t "activerecord.errors.models.user.attributes.email.email_format"
    )
  end

  it "has no password" do
    user.password = nil
    user.valid?
    expect(user.errors.messages[:password]).to include(
      t "activerecord.errors.messages.blank"
    )
  end

  it "has password does not match password confirmation" do
    user.password_confirmation = "456"
    user.valid?
    expect(user.errors[:password_confirmation]).to include(
      t "activerecord.errors.messages.confirmation",
      attribute: t("activerecord.attributes.user.password")
    )
  end

  context "#send_password_reset" do
    let(:user) {create :user}

    it "saves the time the password reset was sent" do
      user.send_password_reset
      expect(user.reload.reset_sent_at).to be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      expect(last_email.to).to include user.email
    end
  end
end
