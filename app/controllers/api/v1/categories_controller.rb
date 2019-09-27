require 'categorable'

class Api::V1::CategoriesController < ApplicationController
  include Categorable

  # GET /api/v1/categories
  def index
    render json: serialize(get_all_categories)
  end

  # GET /api/v1/categories/:id
  def show
    render json: serialize(get_category(params[:id]))
  end

  # POST /api/v1/categories
  def create
    @category = create_category
    render json: serialize(@category),
      status: :created, location: api_v1_category_url(@category)
  end

  # PUT /categories/:id
  def update
    render json: serialize(update_category(params[:id]))
  end

  # DELETE /categories/:id
  def destroy
    destroy_category(params[:id])
    head :no_content
  end
end
