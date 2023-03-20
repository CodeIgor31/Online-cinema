class UsersController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: %i[edit update]
  include UsersHelper

  def index; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    return unless @user.save

    UserMailer.with(user: @user).welcome_email.deliver_now
    flash[:success] = 'На почту выслано письмо, подтвердите, пожалуйста'
    redirect_to home_path
  end

  def update
    @flag = false
    return unless current_user.update user_params

    @flag = true
    flash[:notice] = 'Профиль обновлен'
  end

  private

  def user_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation, :phone,
                                 :old_password)
  end
end
