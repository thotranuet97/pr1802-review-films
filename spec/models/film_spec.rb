require "rails_helper"

RSpec.describe Film, type: :model do
  let(:user) {create :user}
  let(:film) {build :film, user_id: user.id}

  it "is a valid film" do
    expect(film).to be_valid
  end

  it "has no name" do
    film.name = ""
    film.valid?
    expect(film.errors[:name]).to include(
      t "activerecord.errors.messages.blank"
    )
  end
end
