require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do

  describe 'GET #index' do
      let!(:categories) { create_list(:category, 20) }

      before do
        allow_any_instance_of(Api::V1::CategoriesController)
          .to receive(:get_all_categories).and_return(categories)
        get :index, format: :json
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
      end

      it 'loads all of the categories into @categories' do
        expect(JSON.parse(response.body)["data"].size).to eq(categories.size)
      end

      it 'loads only serialized fields' do
        expect(response.body).to include(categories.first.name)
        expect(response.body).to include(categories.last.description)
        expect(response.body).not_to include("\"#{categories.last.created_at.year}-")
      end
  end

  describe 'GET #show' do
    context 'when category exists' do
      let!(:category) { create(:category) }

      before do
        allow_any_instance_of(Api::V1::CategoriesController)
          .to receive(:get_category).and_return(category)
        get :show, params: { id: category.id }, format: :json
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
      end

      it 'loads all of the categories into @categories' do
        expect(response.body).to include(category.name)
        expect(response.body).to include(category.description)
        expect(response.body).not_to include("\"#{category.created_at.year}-")
      end
    end

    context 'when category does not exist' do
      before do
        allow_any_instance_of(Api::V1::CategoriesController).to receive(:get_category)
          .and_raise(ActiveRecord::RecordNotFound.new, "Couldn't find Category")
        get :show, params: { id: 0 }, format: :json
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  describe 'POST #create' do
    context 'when request attributes are valid' do
      let(:params) { attributes_for(:category) }

      before do
        allow_any_instance_of(Api::V1::CategoriesController)
          .to receive(:create_category)
          .and_return(Category.create(params))
        request.accept = 'application/json'
        post :create, params: { category: params }
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(:created)
      end

      it 'responds with created category' do
        expect(response.body).to include(params[:name])
      end
    end

    context 'when request attributes are invalid' do
      let(:error_params) { { description: 'Description without name' } }

      before do
        allow_any_instance_of(Api::V1::CategoriesController)
        .to receive(:create_category)
        .and_raise(ActiveRecord::RecordInvalid.new, "Validation failed: Name can't be blank")
        request.accept = 'application/json'
        post :create, params: { category: error_params }
      end

      it 'responds with error for empty name' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT #update' do
    let(:params) { attributes_for(:category) }

    context 'when categories exists' do
      let!(:category) { create(:category) }

      before do
        allow_any_instance_of(Api::V1::CategoriesController)
          .to receive(:update_category)
          .and_return(Category.update(params))
        put :update, params: { id: category.id, category: params }
      end

      it 'responds successfully with an HTTP 204 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'respond with updated category' do
        expect(response.body).to include(params[:name])
      end
    end

    context 'when category does not exist' do
      before do
        allow_any_instance_of(Api::V1::CategoriesController).to receive(:update_category)
          .and_raise(ActiveRecord::RecordNotFound.new, "Couldn't find Category")
        put :update, params: { id: 0, category: params }
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

    describe 'DELETE /todos/:id' do
      let!(:category) { create(:category) }

      before do
        allow_any_instance_of(Api::V1::CategoriesController)
        .to receive(:destroy_category)
        .and_return(category.destroy)
        delete :destroy, params: { id: category.id }
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
end
