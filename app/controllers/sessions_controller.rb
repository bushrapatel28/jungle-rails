class SessionsController < ApplicationController
  def new
  end

  def create
    @user_info = User.authenticate_with_credentials(params[:email], params[:password])
    # If the user exists AND the password entered is correct.
    if @user_info
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = @user_info.id
      redirect_to root_path
    else
      # If user's login doesn't work, send them back to the login form.
      flash.now[:alert] = 'Invalid email or password.'
      render :new
    end
    
  end

  def destroy
    session[:user_id] = nil
    render :new
  end
end
