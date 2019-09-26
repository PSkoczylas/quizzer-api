require 'rails_helper'

RSpec.describe CategoryRepository do
  let!(:repo) { CategoryRepository.new }

  it 'is a valid category repository' do
    expect(repo).to be_instance_of(CategoryRepository)
  end

  it 'creates queries to ActiveRecord' do
    category = repo.create(name: "abc", description: "abcd")
    expect(category).to be_valid
  end

  it 'has own new method' do
    category = repo.new(name: "abc", description: "abcd")
    expect(category).to be_valid
  end
end
