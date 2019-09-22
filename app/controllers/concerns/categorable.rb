module Categorable
  extend ActiveSupport::Concern

  included do
    before_action :set_category, only: [:show, :edit, :destroy, :update]
    before_action :get_categories, only: [:index]
  end

  private

  def get_categories
    @categories = Category.all
  end

  def category_params
    params.require(:category).permit(:category)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end