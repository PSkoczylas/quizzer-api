module Categorable
  extend ActiveSupport::Concern

  def initialize
    @repo = CategoryRepository.new
    @serializer = CategorySerializer
  end

  def get_all_categories
    @repo.all
  end

  def get_category(id)
    @repo.find(id)
  end

  def create_category
    @repo.create!(category_params)
  end

  def update_category(id)
    @category = get_category(id)
    @category.update(category_params)
    @category
  end

  def destroy_category(id)
    @category = get_category(id)
    @category.destroy
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end