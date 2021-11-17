class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end
  def my_booking
    @booking = Booking.find(params[:id])
  end
end
