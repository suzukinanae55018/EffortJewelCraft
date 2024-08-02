class Admin::DiaryRecordCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = DiaryRecordComment.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def destroy
    @comment = DiaryRecordComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。"
  end
end
