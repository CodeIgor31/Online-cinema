# frozen_string_literal: true

module UsersHelper
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      session[:user_id] = user.id
      flash[:success] = 'Добро пожаловать!'
      redirect_to home_path
    end
  end
end