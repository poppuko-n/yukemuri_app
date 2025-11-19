class Users::AccommodationsController < Users::ApplicationController
  def index
    @form = AccommodationSearchForm.new(accommodation_search_form_params)
    @accommodations = @form.accommodations.published
  end

  private

  def accommodation_search_form_params
    params.fetch(:accommodation_search_form, {}).permit(:category, :prefecture)
  end
end
