class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

# オーナー専用許可待ち一覧
  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page]).per(15)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      flash[:notice] = "グループの作成が成功しました。"
      redirect_to groups_path
    else
      flash.now[:alert] = "グループの作成に失敗しました。"
      render :new
    end
  end

  def index
    @groups = Group.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(params[:id])
    @diary_records = @group.users.joins(:diary_records).select("diary_records.*").page(params[:page]).per(10)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループの更新に成功しました。"
      redirect_to group_path(@group)
    else
      flash.now[:alert] = "グループの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, notice: "グループの削除に成功しました。"
  end
# 自分がオーナーのグループ
  def my_groups
    @groups = current_user.groups.where(owner: current_user.id)
  end
# 自分が参加しているグループ
  def join_groups
    @groups = current_user.groups.all
  end

  private
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image, :theme, :rule)
    end

    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to group_path(@group), alert: "グループオーナーのみ編集が可能です。"
      end
    end
end
