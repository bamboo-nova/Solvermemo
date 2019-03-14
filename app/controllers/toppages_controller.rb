class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build
      @code = current_user.codes.build
      #@posts = current_user.posts.order('created_at DESC').page(params[:page])
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
      @codes = current_user.codes.order('created_at DESC').page(params[:page])
    end
  end
end
