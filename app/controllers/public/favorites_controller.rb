class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @diary_record = DiaryRecord.find(params[:diary_record_id])
    favorite = current_user.favorites.new(diary_record_id: @diary_record.id)
    favorite.save
  end

  def destroy
    @diary_record = DiaryRecord.find(params[:diary_record_id])
    favorite = current_user.favorites.find_by(diary_record_id: @diary_record.id)
    favorite.destroy
  end
end
