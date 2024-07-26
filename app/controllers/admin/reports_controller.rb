class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  # 報告されてdiary_recordのstatusが1になったものを取得
  def index
    @reports = Report.joins(:diary_record).where(diary_records: { status: 1 }).order("created_at DESC").page(params[:page]).per(10)
  end

  def update
    # 特定の１件を取得し、reportに紐づいたdiary_recordのstatusを0（問題なし）に更新する
    @report = Report.find_by(diary_record_id: params[:id])
    @report.diary_record.update(status: 0)
    @report.diary_record.save
    redirect_to admin_reports_path, notice: "問題なしとして報告一覧から削除しました。"
  end
end
