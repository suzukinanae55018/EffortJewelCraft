class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # view側で:rangeを作成
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word]).page(params[:page]).per(14)
    else
      @diary_records = DiaryRecord.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]).per(14)
    end
  end

  def group_search
    @range = params[:range]
    @groups = Group.looks(params[:search], params[:word]).page(params[:page]).per(14)
  end
end
