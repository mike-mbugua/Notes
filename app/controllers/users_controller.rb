class UsersController < ApplicationController
# once you have successfully logged in then 
    def profile
        render json: { user: UserSerializer.new(current_user)}, status: :accepted
    end

# to create/register a new user
    def create
        @user = User.create(user_params)
        if @user.valid?
            @token = encode_token({ user_id: @user.id })
            render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :unprocessable_entity
        end
    end
    

# entities that aren't available to everyone
    private
    def user_params
        params.permit(:username,:email,:password)
    end
end
