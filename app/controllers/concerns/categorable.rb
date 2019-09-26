module Categorable
  extend ActiveSupport::Concern

  included do
    before_action :set_category, only: [:show, :edit, :destroy, :update]
    before_action :set_categories, only: [:index]
    before_action :create_category, only: [:create]
    before_action :update_category, only: [:update]
    before_action :destroy_category, only: [:destroy]
  end

  def initialize
    @repo = CategoryRepository.new
    @serializer = CategorySerializer
  end

  def set_categories
    @categories = @repo.all
  end

  def set_category
    @category = @repo.find(params[:id])
  end

  def create_category
    @category = @repo.create!(category_params)
  end

  def update_category
    @category.update(category_params)
  end

  def destroy_category
    @category.destroy
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end