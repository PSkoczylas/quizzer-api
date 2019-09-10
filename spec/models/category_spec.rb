require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { build(:category) }

  it "has a valid factory" do
    category.should be_valid
  end
end