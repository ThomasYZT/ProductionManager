class SessionsController < ApplicationController
  def create
  	@user = User.authenticate(params[:userid],params[:password],params[:station_code])
  	if @user.nil?
  	  redirect_to home_path, alert: '用户ID或密码错误!'
  	else
      session[:userid] = @user.id
      session[:role] = @user.role
      session[:username] = @user.username

      station = @user.station
      session[:station_title] = station.title
      session[:station_id] = station.id

      redirect_to dashboard_path
  	end
  	
  end

  def delete
  end
end
