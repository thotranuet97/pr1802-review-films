require "rails_helper"

RSpec.describe Review, type: :model do
  let(:user) {create :user}
  let(:film) {create :film, user_id: user.id}
  let(:review) {build :review, user_id: user.id, film_id: film.id}

  it "is a valid review" do
    expect(review).to be_valid
  end

  it "has no title" do
    review.title = ""
    review.valid?
    expect(review.errors[:title]).to include(
      t "activerecord.errors.messages.blank"
    )
  end
end
