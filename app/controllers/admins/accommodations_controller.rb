class Admins::AccommodationsController < Admins::ApplicationController
  before_action :set_accommodation, only: %w[show edit update destroy]
  def index
    @accommodations = Accommodation.all
  end

  def show; end

  def new
    @accommodation = Accommodation.new
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    if @accommodation.save
      redirect_to admins_accommodation_path(@accommodation), notice: t('controller.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit; end

  def update
    if @accommodation.update(accommodation_params)
      redirect_to admins_accommodation_path(@accommodation), notice: t('controller.updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @accommodation.destroy!
    redirect_to admins_root_path, notice: t('controller.destroyed')
  end

  private

  def set_accommodation
    @accommodation = Accommodation.find(params[:id])
  end

  def accommodation_params
    params.require(:accommodation).permit(:name, :prefecture, :address, :phone_number, :category, :image, :description, :published)
  end
end
