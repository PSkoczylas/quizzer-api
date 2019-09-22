require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let!(:category) { create(:category) }

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, params: { category_id: category.id }, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'loads all of the categories into @categories' do
      cat1 = create(:category)
      cat2 = create(:category)
      get :index, params: { category_id: category.id }, format: :json

      expect(response.body).to include(cat1.name)
      expect(response.body).to include(cat2.description)
      expect(response.body).not_to include("\"#{cat2.created_at.year}-")
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: category.id, category_id: category.id }, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'loads all of the categories into @categories' do
      get :show, params: { id: category.id, category_id: category.id }, format: :json

      expect(response.body).to include(category.name)
      expect(response.body).to include(category.description)
      expect(response.body).not_to include("\"#{category.created_at.year}-")
    end
  end
end