class Public::DiaryRecordCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    diary_record = DiaryRecord.find(params[:diary_record_id])
    @comment = current_user.diary_record_comments.new(diary_record_comment_params)
    @comment.diary_record_id = diary_record.id
    @comment.save
  end

  def destroy
    @comment = DiaryRecordComment.find(params[:id])
    @comment.destroy
  end

  private
    def diary_record_comment_params
      params.require(:diary_record_comment).permit(:comment)
    end
end
