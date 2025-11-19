class Users::Reservations::ReviewsController < Users::Reservations::ApplicationController
  def new
    @review = @reservation.reviews.build
  end
end
