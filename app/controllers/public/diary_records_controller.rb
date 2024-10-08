class Public::DiaryRecordsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    # 画像を準備した中から選べるようにする
    @diary_record = DiaryRecord.new
    @images = ["skyblue_background.jpg", "purple_background.jpg", "red_background.jpg", "green_background.jpg", "yellow_background.jpg"]
  end

  def create
    @diary_record = DiaryRecord.new(diary_record_params)
    @diary_record.user_id = current_user.id
    # diary_recordに、viewで作ったbackground_image_name（文字列）を入れる、file_pathに代入してbackground_imageとしてattach
    image_name = params[:diary_record][:background_image_name]
    file_path = Rails.root.join("app", "assets", "images", image_name)
    @diary_record.background_image.attach(io: File.open(file_path), filename: image_name, content_type: image_name)

    if @diary_record.save
      flash[:notice] = "投稿が成功しました。"
      redirect_to diary_record_path(@diary_record.id)
    else
      @images = ["skyblue_background.jpg", "purple_background.jpg", "red_background.jpg", "green_background.jpg", "yellow_background.jpg"]
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @diary_records = DiaryRecord.all.order(created_at: :desc).page(params[:page]).per(14)
    # タグ検索用（あいまい検索）
    if params[:category].present?
      @diary_records = @diary_records.where("category LIKE ?", "%#{params[:category]}%")
    end
  end

  def show
    @diary_record = DiaryRecord.find(params[:id])
    @user = @diary_record.user
    @diary_record_comment = DiaryRecordComment.new
  end

  def edit
    @diary_record = current_user.diary_records.find(params[:id])
    @images = ["skyblue_background.jpg", "purple_background.jpg", "red_background.jpg", "green_background.jpg", "yellow_background.jpg"]
  end

  def update
    @diary_record = current_user.diary_records.find(params[:id])
    # すでに画像がattachされていた場合、いちどpurgeしてからattachし直す
    if params[:diary_record][:background_image_name].present?
      @diary_record.background_image.purge
      image_name = params[:diary_record][:background_image_name]
      file_path = Rails.root.join("app", "assets", "images", image_name)
      @diary_record.background_image.attach(io: File.open(file_path), filename: image_name, content_type: "image/jpeg")
    end

    if @diary_record.update(diary_record_params)
      flash[:notice] = "投稿の編集に成功しました。"
      redirect_to diary_record_path(@diary_record.id)
    else
      @images = ["skyblue_background.jpg", "purple_background.jpg", "red_background.jpg", "green_background.jpg", "yellow_background.jpg"]
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
  # 投稿のuser_idがログイン中のuser_idではなかった場合
  def is_matching_login_user
    diary_record = DiaryRecord.find(params[:id])
    unless diary_record.user_id == current_user.id
      redirect_to diary_records_path, notice: "他のユーザーの投稿編集はできません。"
    end
  end
end
