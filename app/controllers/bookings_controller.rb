class BookingsController < ApplicationController
  before_action :set_pet, :set_user, only: [:new,:create, :index, :destroy]

  def index

  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.pet = @pet
    @booking.save!
    redirect_to pet_bookings_path
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking.update(booking)
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking.destroy
    redirect_to pets_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_user
    @user = current_user
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
