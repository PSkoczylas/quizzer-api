require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let!(:category) { create(:category) }
  let!(:categories) { create_list(:category, 30)}

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end

    it 'loads all of the categories into @categories' do
      get :index, format: :json

      expect(response.body).to include(categories.first.name)
      expect(response.body).to include(categories.last.description)
      expect(response.body).not_to include("\"#{categories.last.created_at.year}-")
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      get :show, params: { id: category.id, category_id: category.id }, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end

    it 'loads all of the categories into @categories' do
      get :show, params: { id: category.id, category_id: category.id }, format: :json

      expect(response.body).to include(category.name)
      expect(response.body).to include(category.description)
      expect(response.body).not_to include("\"#{category.created_at.year}-")
    end
  end

  describe 'POST #create' do
    let(:params) { attributes_for(:category) }
    let(:error_params) { { description: 'Description without name' } }

    it 'responds successfully with an HTTP 200 status code' do
      request.accept = 'application/json'
      post :create, params: { category: params }

      expect(response).to be_successful
      expect(response).to have_http_status(:created)
    end

    it 'responds with created category' do
      request.accept = 'application/json'
      post :create, params: { category: params }

      expect(response.body).to include(params[:name])
    end


    it 'responds with error for empty name' do
      request.accept = 'application/json'
      post :create, params: { category: error_params }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end