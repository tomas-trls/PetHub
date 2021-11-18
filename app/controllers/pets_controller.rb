class PetsController < ApplicationController
  before_action :find_pet, only: [:show, :edit, :update]
  def show
    @pet = Pet.find(params[:id])
    @current_bookings = @pet.bookings.where.not(bookingStatus: "rejected")
    # @current_bookings = @pet.bookings.order('start_date ASC').reject { |booking| booking.bookingStatus == "rejected"  }
    @booking = Booking.new
  end

  def index
    @pets = Pet.all
    @markers = @pets.geocoded.map do |pet|
      {
        lat: pet.latitude,
        lng: pet.longitude,
        info_window: render_to_string(partial: "info_window", locals: { pet: pet }),
        image_url: helpers.asset_url("redpaw.png")
      }
    end
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new
    end
  end

  def update
    if @pet.update(pet_params)
      redirect_to pet_path(@pet)
    else
      render :edit
    end
  end

  def edit; end

  private

  def find_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :description, :breed, :age, :photo, :address)
  end
end
