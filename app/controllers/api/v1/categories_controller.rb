require 'categorable'

class Api::V1::CategoriesController < ApplicationController
  include Categorable

  def index
    render json: CategorySerializer.new(@categories)
  end

  def show
    render json: CategorySerializer.new(@category)
  end
end
