class Users::AccommodationsController < Users::ApplicationController
  before_action :set_accommodation, only: %i[show]
  def index
    @form = AccommodationSearchForm.new(accommodation_search_form_params)
    @accommodations = @form.accommodations.published
  end

  def show; end

  private

  def accommodation_search_form_params
    params.fetch(:accommodation_search_form, {}).permit(:category, :prefecture)
  end

  def set_accommodation
    @accommodation = Accommodation.find(params[:id])
  end
end
