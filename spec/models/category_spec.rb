require "rails_helper"

RSpec.describe Category, type: :model do
  let (:category) {build :category}

  it "is a valid category" do
    expect(category).to be_valid
  end

  it "does not have a name" do
    category.name = ""
    category.valid?
    expect(category.errors[:name]).to include(
      t "activerecord.errors.messages.blank"
    )
  end
end
