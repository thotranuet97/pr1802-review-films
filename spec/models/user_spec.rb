require "rails_helper"

describe User do
  describe "#send_password_reset" do
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
