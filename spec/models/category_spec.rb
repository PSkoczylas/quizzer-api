require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { build(:category) }

  it "has a valid factory" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    expect validate_presence_of(:name)
  end

  it "is valid without description" do
    valid_category = build(:category, description: nil)
    expect(valid_category).to be_valid
  end

  it "is valid with maximum name length" do
    expect validate_length_of(:name).is_at_most(30)
  end
end
