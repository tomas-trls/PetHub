class PetsController < ApplicationController
  before_action :find_pet, only: [:show]
  def show
  end

  def index
    @pets = Pet.all
    @markers = @pets.geocoded.map do |pet|
      {
        lat: pet.latitude,
        lng: pet.longitude
      }
    end
  end

  private

  def find_pet
    @pet = Pet.find(params[:id])
  end
end
