class Public::DiaryRecordsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def new
    @diary_record = DiaryRecord.new
  end

  def create
    @diary_record = DiaryRecord.new(diary_record_params)
    @diary_record.user_id = current_user.id

    if @diary_record.save
      flash[:notice] = "投稿が成功しました。"
      redirect_to diary_record_path(@diary_record.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @diary_records = DiaryRecord.all.order(created_at: :desc).page(params[:page]).per(15)
     if params[:category].present?
       @diary_records = @diary_records.where(category: params[:category])
     end
  end

  def show
    @diary_record = DiaryRecord.find(params[:id])
    @user = @diary_record.user
    @diary_record_comment = DiaryRecordComment.new
  end

  def edit
    @diary_record = DiaryRecord.find(params[:id])
  end

  def update
    @diary_record = current_user.diary_records.find(params[:id])

    if @diary_record.update(diary_record_params)
      flash[:notice] = "投稿の編集に成功しました"
      redirect_to diary_record_path(@diary_record.id)
    else
      flash.now[:alert] = "投稿の編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    diary_record = current_user.diary_records.find(params[:id])

    if diary_record.destroy
      flash[:notice] = "投稿の削除に成功しました"
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "投稿の削除に失敗しました。"
      render :edit
    end
  end

  private

  def diary_record_params
    params.require(:diary_record).permit(:title, :body, :category, :diary_record_image, :background_image)
  end

  def is_matching_login_user
    diary_record = DiaryRecord.find(params[:id])
      unless diary_record.user_id == current_user.id
        redirect_to diary_records_path, notice: "他のユーザーの投稿編集はできません。"
      end
  end
end
