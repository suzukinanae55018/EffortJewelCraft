class Public::SearchesController < ApplicationController
before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word]).page(params[:page]).per(15)
    else
      @diary_records = DiaryRecord.looks(params[:search], params[:word]).page(params[:page]).per(15)
    end
  end

  def group_search
    @range = params[:range]
    @groups = Group.looks(params[:search], params[:word]).page(params[:page]).per(15)
  end
end
