class Api::SessionsController < ApplicationController
  def create
    if current_user
      render json: ["How did you get here? There's already somebody signed in!"], status: 404
      return
    end
    
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
      render "api/users/show"
    else
      render json: ["Invalid username or password. Please try again"], status: 401
    end
  end

  def destroy
    @user = current_user

    if @user
      logout
      render "api/users/show"
    else
      render json: ["How did you get here? There's nobody signed in!"], status: 404
    end
  end
end
