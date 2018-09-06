require "rails_helper"

RSpec.describe Rating, type: :model do
  let (:user) {create :user}
  let (:film) {create :film, user_id: user.id}
  let (:rating) {build :rating, user_id: user.id, film_id: film.id}

  it "is a valid rating" do
    expect(rating).to be_valid
  end

  it "does not have a rate" do
    rating.rate = ""
    rating.valid?
    expect(rating.errors[:rate]).to include(
      t "activerecord.errors.messages.blank"
    )
  end
end
