# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authorize_user
  before_action :set_appointment, only: %i[show update destroy]

  def index
    @appointments = @current_user.appointments
    render json: @appointments, include: %i[doctor], status: 200
  end

  def show
    render json: @appointment, status: 200
  end

  api :POST, 'appointments/new'
  param :date, :String, required: true
  param :slot_number, :number, required: true
  param :doctor_id, :number, required: true
  def create
    if Doctor.find(params[:doctor_id]).appointments.where(["date = ? and slot = ?", params[:date], params[:slot_number]]).empty?
      @appointment = @current_user.appointments.create(date: params[:date],
        doctor_id: params[:doctor_id], slot: a_params[:slot_number])
        render json: @appointment, status: 201
    else
      render json: { error: 'Appointment could not be created!' }, status: 404
    end
  end

  def update
    if @appointment.update(date: a_params[:date], doctor_id: a_params[:doctor_id],
                           branch: a_params[:branch])
      render json: @appointment, status: 200
    else
      render json: { error: 'Could not update appointment!' }, status: 422
    end
  end

  def destroy
    @appointment.destroy
    render json: { message: 'Successfully deleted appointment!', deleted_appointment: @appointment }, status: 200
  end

  private

  def a_params
    params.require(:appointment).permit(:date, :doctor_id, :branch)
  end

  def set_appointment
    @appointment = @current_user.appointments.find(params[:id])
  end
end
