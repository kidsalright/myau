class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  def show; end

  def index; end

  def create
    @user = User.create(user_params)
  end

  def update
    @user.update(user_params)
  end

  private

  def set_user
    @user= User.find(params[:id])
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
  end

  def user_params
    params.require(:user).permit(:avatar)
  end
end
