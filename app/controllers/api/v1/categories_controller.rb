require 'categorable'

class Api::V1::CategoriesController < ApplicationController
  include Categorable

  def index
    render json: CategorySerializer.new(@categories)
  end

  def show
    render json: CategorySerializer.new(@category)
  end

  def create
    if @category.save
      render json: @category, status: :created, location: api_v1_category_url(@category)
    else
      render json: { errors: @category.errors }, status: :unprocessable_entity
    end
  end
end