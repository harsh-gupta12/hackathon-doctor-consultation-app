class Api::V1::DoctorsController < ApplicationController
  before_action :authorize_user, except: %i[index show]
  before_action :set_doctor, only: %i[show update destroy]

  def index
    @doctors = doctor.order_by_name
    render json: @doctors, status: 200
  end

  def create
    @doctor = doctor.create!(doctor_params)
    render json: @doctor, status: :created
  end

  def show
    render json: @doctor, status: 200
  end

  def update
    if @doctor.update(doctor_params)
      render json: @doctor, status: 200
    else
      render json: { error: 'doctor could not be updated.' }, status: 404
    end
  end

  def destroy
    @doctor.destroy
    render json: { message: 'Successfully deleted', deleted_doctor: @doctor }, status: 200
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :description, :img)
  end

  def set_doctor
    @doctor = doctor.find(params[:id])
  end
end
