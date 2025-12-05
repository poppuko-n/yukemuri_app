class Users::Accommodations::ApplicationController < Users::ApplicationController
  before_action :set_accommodation

  private

  def set_accommodation
    @accommodation = Accommodation.find(params[:accommodation_id])
  end
end
