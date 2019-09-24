module Categorable
  extend ActiveSupport::Concern

  included do
    before_action :set_category, only: [:show, :edit, :destroy, :update]
    before_action :get_categories, only: [:index]
    before_action :create_category, only: [:create]
  end

  private

  def get_categories
    @categories = Category.all
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def create_category
    @category = Category.new(category_params)
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end