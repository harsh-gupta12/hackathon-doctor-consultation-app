# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_user, only: [:show]

      def show
        render json: @current_user, status: 200
      end

      def create
        @user = User.create!(username: user_params[:username], password: user_params[:password], mobile: user_params[:mobile]
                             email: user_params[:email], name: user_params[:name], dob: user_params[:username])

        if @user.valid?
          token = encode_token({ user_id: @user.id })
          render json: { status: :created, user: user_data(@user), token: token }, status: 201
        else
          render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :password, :user_id, :mobile, :email, :dob, :name)
      end

      def user_data(user)
        {
          id: user.id,
          name: user.name,
          mobile: user.mobile,
          email: user.email
          dob: user.dob,
          username: user.username,
          password: user.password,
          admin: user.admin
        }
      end
    end
  end
end
