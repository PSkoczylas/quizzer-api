require 'categorable'

class Api::V1::CategoriesController < ApplicationController
  include Categorable

  # GET /api/v1/categories
  def index
    render json: CategorySerializer.new(@categories)
  end

  # GET /api/v1/categories/:id
  def show
    render json: CategorySerializer.new(@category)
  end

  # POST /api/v1/categories
  def create
    render json: @category, status: :created, location: api_v1_category_url(@category)
  end

  # PUT /todos/:id
  def update
    render json: @category
  end

  # DELETE /todos/:id
  def destroy
    head :no_content
  end
end