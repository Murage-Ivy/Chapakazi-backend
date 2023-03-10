class ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_review_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  skip_before_action :authorized, only: [:index]

  def index
    if params[:handyman_id]
      handyman = find(params[:handyman_id])
      handyman.reviews
    else
      reviews = Review.all
    end

    render json: reviews, status: :ok
  end

  def show
    review = Review.find(params[:id])
    render json: review, status: :ok
  end

  def create
    review = current_customer.reviews.create!(review_params)
    render json: review, status: :created
  end

  def update
    review = find_review
    review = Review.update!(review_params)
    render json: review, status: :accepted
  end

  def destroy
    review = find_review
    review.destroy
    head :no_content
  end


  def increment_likes
    review = find_review
    if review
      Review.update(votes:review.votes + 1 || 1)
      render json: review, status: :accepted
    end
  end

  def decrement_likes
    review = find_review
    if review
      Review.update(votes:review.votes - 1 || 0)
      render json: review, status: :accepted
    end
  end


  private

  def find_review
    Review.find(params[:id])
  end

  def review_params
    params.permit(:handyman_id, :comment, :votes)
  end

  def render_review_not_found_response
    render json: { errors: ["Review not found"] }, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
