class UserCodesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    code = Code.find(params[:code_id])
    current_user.code_like(code)
    flash[:success] = 'コードをお気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    code = Code.find(params[:code_id])
    current_user.code_unlike(code)
    flash[:success] = 'コードのお気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
