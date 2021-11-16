class BookingsController < ApplicationController
  before_action :set_pet, :set_user, only: [:new, :create]
  def index

  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @booking.pet = @pet
    @booking.save!
    redirect_to booking_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
