require 'rails_helper'
require 'airborne'

RSpec.describe 'request categories actions', type: :request do
  it 'returns all categories' do
    categories = create_list(:category, 10)
    get "/api/v1/categories"
    length = Category.all.size
    expect(response).to have_http_status(200)
    expect_json_sizes(data: length)
    expect_json_types(data: :array)
  end

  let!(:category) { create(:category) }

  it 'shows given category' do
    get "/api/v1/categories/#{category.id}"
    expect(response).to have_http_status(200)
    expect_json('data.attributes', name: category.name)
  end

  it 'creates given category' do
    params = attributes_for(:category)
    post "/api/v1/categories/", params: { category: params }
    expect(response).to have_http_status(:created)
    expect_json('data.attributes', name: params[:name])
  end

  it 'updates given category' do
    params = attributes_for(:category)
    category_to_update = create(:category)
    put "/api/v1/categories/#{category_to_update.id}", params: { category: params }
    expect(response).to have_http_status(200)
    expect_json('data.attributes', name: params[:name])
  end

  it 'destroys given category' do
    category_to_destroy = create(:category)
    delete "/api/v1/categories/#{category_to_destroy.id}"
    expect(response).to have_http_status(204)
  end
end
