class PetsController < ApplicationController
  before_action :find_pet, only: [:show]
  def show
    @pet = Pet.find(params[:id])
    @booking = Booking.new
  end

  def index
    @pets = Pet.all
  end

  private

  def find_pet
    @pet = Pet.find(params[:id])
  end
end
