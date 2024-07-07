class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @diary_records = @user.diary_records
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    # @users = User.all
    # if params[:name].present?
    #   @users = @users.where(username: params[:name])
    # end
    
    # if params[:category_id].present?
      
    # end
  end
end
