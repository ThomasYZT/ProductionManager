module Api
  module V1
    class SessionsController < ApiController

      skip_before_filter :restrict_access

      def create
        user = User.authenticate(params[:session][:userid],
                                 params[:session][:password],
                                 params[:session][:station_code])

        return render json: {code: 200, 
                             user: {username: user.username, 
                                    token: user.token,
                                    phone: user.phone,
                                    station_id: user.station_id}} if user

        return render json: {code: 404}
      end

    end
  end
end
