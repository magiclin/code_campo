class UserSessionsController < ApplicationController
  def new
  end

  def create
    login = /^#{params[:login]}$/i
    user = User.any_of({:name => login}, {:email => login}).first
    if user and user.authenticate(params[:password])
      login_as user
      redirect_to root_url
    else
      flash[:error] = 'Wrong login name or password'
      redirect_to login_url
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
