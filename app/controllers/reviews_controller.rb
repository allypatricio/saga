class ReviewsController < ApplicationController
  before_action :set_booking, :set_tour

  def new
    if Review.where(user_id: current_user.id, booking_id: params[:booking_id]).any?
      @review = Review.where(user_id: current_user.id, booking_id: params[:booking_id]).first
    else
      @review = Review.new
    end
  end

  def create
    @review = Review.new(review_params)
    @review.booking_id = @booking.id
    @review.user_id = current_user.id
    @review.tour_id = @tour.id
    if @review.save
      redirect_to dashboard_index_path
    else
      render :new
      # render 'dashboard/index'
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.content = review_params[:content]
    @review.rating = review_params[:rating]
    @review.save
    redirect_to dashboard_index_path
  end

  def show
  end

  def destroy
  end

  private

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
