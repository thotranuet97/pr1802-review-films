require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) {create :user}
  let(:film) {create :film, user_id: user.id}
  let(:review) {create :review, user_id: user.id, film_id: film.id}
  let(:comment) {build :comment, user_id: user.id, commentable: review}

  it "is a valid comment" do
    expect(review).to be_valid
  end

  it "has no content" do
    comment.content = ""
    comment.valid?
    expect(comment.errors[:content]).to include(
      t "activerecord.errors.messages.blank"
    )
  end

  it "has content too short" do
    comment.content = "1"
    comment.valid?
    expect(comment.errors[:content]).to include(
      t "activerecord.errors.messages.too_short",
        count: Settings.comment.content.length.minimum
    )
  end
end
