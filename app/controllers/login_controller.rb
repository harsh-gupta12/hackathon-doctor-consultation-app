class Api::V1::LoginController < ApplicationController
  def create
    @user = User.find_by(email: login_params[:email])

    if @user&.authenticate(login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { logged_in: true, user: user_data(@user), token: token }
    else
      render json: { errors: 'Invalid Password' }, status: 401
    end
  end

  def auto_login
    @user = User.find(login_params[:user_id])

    if @user
      render json: { logged_in: true, user: user_data(@user) }
    else
      render json: { error: 'token is wrong or expired, please login Again' }
    end
  end

  private

  def login_params
    params.require(:user).permit(:username, :password, :user_id, :mobile, :email, :dob, :name)
  end

  def user_data(user)
    {
      id: user.id,
      username: user.username,
      name: user.name,
      mobile: user.mobile,
      email: user.email
      dob: user.dob,
      admin: user.admin
    }
  end
end
