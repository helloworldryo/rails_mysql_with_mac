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
    @user = User.new(name: params[:name], email: params[:email], image_name: "default_user.jpg", password: params[:password])
    # Redirect to the "Users" page if the @user is valid, and render the "New User" page if it isn't
    if @user.save
      session[:user_id] = @user.id
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

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "Your account has been updated successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  def login_form
  end
  def login
    # Get the user with the email and the password, then assign it to the @user variable
    @user = User.find_by(email: params[:email], password: params[:password])
    # Redirect to the "Posts" page if the @user exists, and render the "Login Form" page if it isn't
    if @user
      # Store the id of the user in session[:user_id]
      session[:user_id] = @user.id
      flash[:notice] = "You have logged in successfully"
      redirect_to("/posts/index")
    else
      # Define the @error_message variables
      @error_message = "Invalid email/password combination"
      # Define variables @email and @password
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "You have logged out successfully"
    redirect_to("/login")
  end

end
