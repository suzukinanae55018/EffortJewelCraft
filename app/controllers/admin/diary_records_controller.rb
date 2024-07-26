class Admin::DiaryRecordsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @diary_records = DiaryRecord.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def destroy
    diary_record = DiaryRecord.find(params[:id])

    if diary_record.destroy
      flash[:notice] = "投稿の削除に成功しました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "投稿の削除に失敗しました。"
      render :edit
    end
  end
end
