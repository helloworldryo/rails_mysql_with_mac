class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    # Create a new instance of User, then assign it to the @user variable
    @user = User.new

  end

  def create
    @user = User.new(name: params[:name], email: params[:email], image_name: "default_user.jpg")
    # Redirect to the "Users" page if the @user is valid, and render the "New User" page if it isn't
    if @user.save
      flash[:notice] = "You have signed up successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
  @user = User.find_by(id: params[:id])
  @user.name = params[:name]
  @user.email = params[:email]
  if @user.save
    flash[:notice] = "Your account has been updated successfully"
    redirect_to("/users/#{@user.id}")
  else
    render("users/edit")
  end
end

end
