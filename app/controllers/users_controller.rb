class UsersController < ApplicationController
    skip_before_action :authorize, only: :create

    # In the create action, if the user is valid:
    # Save a new user to the database with their username, encrypted password, image URL, and bio
    # Save the user's ID in the session hash
    # Return a JSON response with the user's ID, username, image URL, and bio; and an HTTP status code of 201 (Created)
    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    # In the show action, if the user is logged in (if their user_id is in the session hash):
    # Return a JSON response with the user's ID, username, image URL, and bio; and an HTTP status code of 201 (Created)
    def show 
        render json: @current_user
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
