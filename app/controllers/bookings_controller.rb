class BookingsController < ApplicationController
  before_action :set_pet, :set_user, only: %i[new create]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
    # @pet_price = Pet.where("created_at >= ? AND created_at < ?", Time.now.beginning_of_day, Time.now.end_of_day).sum(:price)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.pet = @pet
    if @booking.save
      redirect_to my_bookings_path
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    if @booking.save
      redirect_to my_bookings_path
    else
      render :edit
    end
  end

  def confirm_booking
    @booking = Booking.find(params[:id])
    @booking.update(bookingStatus: "accepted")
    redirect_to pet_path(@booking.pet)
  end

  def cancel_booking
    @booking = Booking.find(params[:id])
    @booking.update(bookingStatus: "cancelled")
    redirect_to pet_path(@booking.pet)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    if @booking.pet.user == current_user
      redirect_to pet_path(@booking.pet)
    else
      redirect_to my_bookings_path
    end
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
