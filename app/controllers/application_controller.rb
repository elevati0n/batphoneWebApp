class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def encrypt(string, public_key_file)

     if public_key_file.nil?
       public_key_file = 'public.pem';
     end

  public_key =
      OpenSSL::PKey::RSA.new(File.read(public_key_file))
  encrypted_string =
      Base64.encode64(public_key.public_encrypt(string))



    return encrypted_string



  end

 end
