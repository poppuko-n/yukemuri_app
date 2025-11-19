class Users::Reservations::ReviewsController < Users::Reservations::ApplicationController
  def new
    @review = @reservation.reviews.build
  end

  def create
    @review = @reservation.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to users_root_path, notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
