class ReviewsController < ApplicationController
  before_action :set_booking

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.booking_id = @booking.id
    if @review.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def show
  end

  def destroy
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
