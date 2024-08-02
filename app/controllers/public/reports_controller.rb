class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @report = Report.new
    @diary_record = DiaryRecord.find(params[:diary_record_id])
  end

  def create
    diary_record = DiaryRecord.find(params[:diary_record_id])
    report = current_user.reports.new(report_params)
    report.diary_record_id = diary_record.id
    # 報告された投稿ステータスを１とする、デフォルトは０
    if report.save
      diary_record.update(status: 1)
      flash[:notice] = "管理者に報告しました"
      redirect_to complete_diary_record_path(diary_record)
    else
      @report = Report.new
      @diary_record = DiaryRecord.find(params[:diary_record_id])
      flash[:alert] = "100文字以内で報告内容を入力してください"
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:report)
  end
end
