class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  # コメント追加
  def create
    @comment = Comment.new(comment_params)
    #redirect_to "/users/#{@comment.reply_comment}"
    @comment.save!
    if @comment.save
      flash[:success] = '返信しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = '返信に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @comment.destroy
    #@comment = Comment.find(params[:id]).destroy
    #redirect_to "/users/#{@comment.reply_comment}"
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def comment_params
    comment_params = params.require(:comment).permit(:content, :image, :reply_comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end  
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
