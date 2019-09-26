require 'categorable'

class Api::V1::CategoriesController < ApplicationController
  include Categorable

  # GET /api/v1/categories
  def index
    render json: serialize(@categories)
  end

  # GET /api/v1/categories/:id
  def show
    render json: serialize(@category)
  end

  # POST /api/v1/categories
  def create
    render json: serialize(@category),
      status: :created, location: api_v1_category_url(@category)
  end

  # PUT /categories/:id
  def update
    render json: serialize(@category)
  end

  # DELETE /categories/:id
  def destroy
    head :no_content
  end
end
