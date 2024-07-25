class Admin::ReportsController < ApplicationController
   before_action :authenticate_admin!
  def index
    @reports = Report.joins(:diary_record).where(diary_records: { status: 1 }).order("created_at DESC").page(params[:page]).per(10)
  end
end
