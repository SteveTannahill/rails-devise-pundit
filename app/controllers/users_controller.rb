class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if params[:user][:labels]
      new_label = Label.find(params[:user][:labels])
      unless @user.labels.include?(new_label)
        @user.labels << new_label
        @user.save
        redirect_to users_path, :notice => "Label added user."
      else
        redirect_to users_path, :notice => "User already has that label."
      end
    else
      if @user.update_attributes(secure_params)
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :label)
  end

end
