class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
      @group.owner_id = current_user.id
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
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループの更新に成功しました。"
      redirect_to groups_path
    else
      flash.now[:alert] = "グループの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])

    if group.destroy
      flash[:notice] = "グループの削除に成功しました"
      redirect_to groups_path
    else
      flash.now[:alert] = "グループの削除に失敗しました。"
      render :show
    end
  end

  private

    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end

    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path, notice: "他のユーザーが作ったグループの編集はできません。"
      end
    end
end
