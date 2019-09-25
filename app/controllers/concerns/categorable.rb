module Categorable
  extend ActiveSupport::Concern

  included do
    before_action :set_category, only: [:show, :edit, :destroy, :update]
    before_action :get_categories, only: [:index]
    before_action :create_category, only: [:create]
  end

  def get_categories
    @categories = repo.all
  end

  def set_category
    @category = repo.find_by(id: params[:id])
  end

  def create_category
    @category = repo.new(category_params)
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def repo
    CategoryRepository.new
  end
end