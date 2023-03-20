# frozen_string_literal: true

# session controller
class SessionsController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: :destroy
  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password]) # Для безопасности(Если юзер будет nil,
      # то к нему не применится метод и мы направимся в else)
      if user.email_confirmed == true
        session[:user_id] = user.id
        flash[:success] = 'Успешный вход'
        redirect_to home_path
      else
        flash[:success] = 'Подтвердите почту'
        redirect_to session_path
      end
    else
      flash[:warning] = 'Неправильный email или пароль'
      redirect_to session_path
    end
  end

  def destroy
    session.delete :user_id
    flash[:success] = 'Успешный выход'
    redirect_to home_path
  end
end