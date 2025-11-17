class Admins::AccommodationsController < Admins::ApplicationController
  def index

  end

  def new
    @accommodation = Accommodation.new
  end

  def create

  end

  private

  def accommodation_params

  end
end
