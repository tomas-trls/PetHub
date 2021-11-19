class ReviewsController < ApplicationController
  def show
    @review
  end

  def index
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end
end
