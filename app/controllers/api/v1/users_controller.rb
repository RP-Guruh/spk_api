class Api::V1::UsersController < ApplicationController
    def create
      @user = User.new(user_params)
  
      if @user.save
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: :ok
      else
        render json: { error: 'Invalid username or password' }, status: :unprocessable_entity
      end
    end

    def login
        @user = User.find_by(username: user_params[:username])
        if @user && @user.authenticate(user_params[:password])
            token = encode_token({user_id: @user.id})
            time = Time.now + 1.minute #Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                           username: @user.username }, status: :ok
        else
            render json: {error: "invalid username or password"}, status: :unprocessable_entity
        end
    end
  
    private
  
    def user_params
      params.permit(:fullname, :email, :username, :password)
    end
  
end
  