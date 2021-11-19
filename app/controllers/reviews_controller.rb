class ReviewsController < ApplicationController
  before_action :find_review, only: %i[show destroy]
  def show; end

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @booking = Booking.find(params[:review][:booking_id])
    # raise
    if @booking.owner_confirmation == true && @booking.sitter_confirmation == true && @booking.end_date <= DateTime.now
      @review = Review.new(review_params)
      @review.save!
    else
      puts "Something failed #{@booking.end_date <= Date.new}"
    end
    redirect_to my_booking_path(@booking)
  end

  def destroy
    @booking = Review.find(params[:id]).booking
    @review.destroy
    redirect_to my_booking_path(@booking)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :booking_id)
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
