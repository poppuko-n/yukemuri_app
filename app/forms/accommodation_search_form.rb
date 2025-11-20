class AccommodationSearchForm < ApplicationForm
  attribute :category
  attribute :prefecture

  def accommodations
    scope = Accommodation.all

    scope = scope.where(category: category) if category.present?
    scope = scope.where(prefecture: prefecture) if prefecture.present?

    scope
  end
end
