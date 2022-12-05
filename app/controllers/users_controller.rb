class UsersController < ApplicationController
    wrap_parameters format: []

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    rescue ActiveRecord::RecordInvalid  => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: 422
    end

    def show
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            render json: user
        else
            render json: {error: "You need to Login"}, status: 401
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
