class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      remember user
      redirect_to user
    else
	    flash.now[:danger] = 'Invalid email/password combination'
	    render 'new'
    end
end
   
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end  
  
#  def self.sweep(time = 1.hour)
#  if time.is_a?(String)
#  time = time.split.inject { |count, unit| count.to_i.send(unit) }
#  end
#  delete_all "updated_at < '#{time.ago.to_s(:db)}'"
#  end
#  end  
end
