class Admins::AccommodationsController < Admins::ApplicationController
  def index
    @accommodations = Accommodation.all
  end

  def show
    @accommodation = Accommodation.find(params[:id])
  end

  def new
    @accommodation = Accommodation.new
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    if @accommodation.save
      redirect_to admins_root_path, notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def accommodation_params
    params.require(:accommodation).permit(:name, :prefecture, :address, :phone_number, :category, :image, :description, :published)
  end
end
