require 'rails_helper'

RSpec.describe CategoriesConcern, type: :controller  do
  controller(ApplicationController) do
    include CategoriesConcern
    def create
      return create_category
    end

    def update
      update_category(params[:id])
    end
  end

  before do
    class FakeController < ApplicationController
      include CategoriesConcern
    end
  end

  after { Object.send :remove_const, :FakeController }
  let(:object) { FakeController.new }

  describe 'initialize' do
    it 'is a valid concern' do
      expect(object).to be_instance_of(FakeController)
    end
  end

  describe 'get all categories' do
    it 'returns all categories' do
      categories = create_list(:category, 20)
      return_value = object.get_all_categories
      expect(return_value.size).to eq(categories.size + 1)
    end
  end

  describe 'get category' do
    it 'returns given category' do
      categories = create_list(:category, 5)
      return_value = object.get_category(categories.last.id)
      expect(return_value).to eq(Category.find(categories.last.id))
    end
  end

  describe 'create category' do
    it 'adds new category' do
      params = attributes_for(:category)
      before_length = Category.all.size
      return_value = post :create, params: { category: params }
      expect(Category.all.size).to eq(before_length + 1)
    end
  end

  describe 'update category' do
    it 'updates new category' do
      category = create(:category)
      params = attributes_for(:category)
      id = category.id
      return_value = post :update, params: { id: id, category: params }
      expect(Category.find(id).name).to eq(params[:name])
    end
  end

  describe 'destroy category' do
    it 'destroy given category' do
      category = create(:category)
      length = Category.all.length
      object.destroy_category(Category.last.id)
      expect(Category.all.length).to eq(length - 1)
    end
  end
end