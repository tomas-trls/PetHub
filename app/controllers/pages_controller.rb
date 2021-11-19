class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def my_booking
    @booking = Booking.find(params[:id])
  end

  def my_bookings
    @my_bookings = current_user.bookings
  end

  def my_dashboard
    sort_by = params[:sort_by] if params[:sort_by].present?
    @pet_bookings = set_pet_bookings
    case sort_by
    when "Pending"
      @my_bookings = current_user.bookings.where(bookingStatus: "pending")
    when "Upcoming bookings"
      @my_bookings = current_user.bookings.where(bookingStatus: "accepted")
    when "History"
      @my_bookings = current_user.bookings.where(owner_confirmation: true, sitter_confirmation: true)
    else
      @my_bookings = current_user.bookings
    end
  end

  def set_pet_bookings
    pet_sort_by = params[:pet_sort_by] if params[:pet_sort_by].present?
    case pet_sort_by
    when "Pending"
      @pet_bookings = Booking.joins(:pet).where({ pets: { user_id: "#{current_user.id}" }, bookingStatus: "pending" })
    when "Upcoming bookings"
      @pet_bookings = Booking.joins(:pet).where({ pets: { user_id: "#{current_user.id}" }, bookingStatus: "accepted" })
    when "History"
      @pet_bookings = Booking.joins(:pet).where({ pets: { user_id: "#{current_user.id}" }, owner_confirmation: true, sitter_confirmation: true })
    else
      @pet_bookings = Booking.joins(:pet).where({ pets: { user_id: "#{current_user.id}" } })
    end
  end
end
