class PetsController < ApplicationController
  before_action :find_pet, only: [:show]
  def show
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

  private

  def find_pet
    @pet = Pet.find(params[:id])
  end
end
