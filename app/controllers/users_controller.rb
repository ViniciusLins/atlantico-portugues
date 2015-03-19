class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :create, :new]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy, :create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Usuário criado com sucesso!"
      redirect_to root_path 
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path)  unless current_user?(@user)
    end

end
