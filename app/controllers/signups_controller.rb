class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable

  def create
    signup = Signup.create!(signup_params)
    render json: signup, include: :activity, status: :created
  end

  private

  def signup_params
    params.permit(:activity_id, :camper_id, :time)
  end

  def render_unprocessable(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
