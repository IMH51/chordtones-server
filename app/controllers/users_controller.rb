class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { token: issue_token({id: @user.id}) }
    else
      render json: {error: "Can't create user, username may already be taken"}, status: 401
    end
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      render json: { token: issue_token({id: @user.id}) }
    else
      render json: {error: 'Invalid user/password combination.'}, status: 404
    end
  end

  def chords
    @user = get_current_user
    if @user
      render json: @user.chords
    else
      render json: {error: "Invalid User Id."}, status: 401
    end
  end

  def show
    render json: User.find(params[:id])
  end

  private

  def user_params
    params.permit(:username, :password)
  end

end
