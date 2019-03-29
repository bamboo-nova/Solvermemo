class CodesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @code = current_user.codes.build
    @tags = Tag.all
  end

  def create
    @code = current_user.codes.build(code_params)
    #@tag = code.tags.build(tag_params)
    if @code.save
      flash[:success] = 'コードを公開しました。'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
      @codes = current_user.codes.order('created_at DESC').page(params[:page])
      flash[:danger] = 'コードの公開に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @code.destroy
    flash[:success] = 'コードを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def download
    @code = Code.find(params[:id])
    filepath = @code.data.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @code.data_identifier, :length => stat.size)
  end
  
  def search
    @results = []
    item = Code.search(params[:keyword])
    @results = item
  end
  
  def similarity
    @program = params[:program]
    @codes = Code.all
    if @program.present?
      @similar = Cosine.calculate(@program, @codes)
      #@result = @similar.index(@similar.max)
      @results = @similar
    end
  end
  
  
  private
  
  def code_params
    params.require(:code).permit(:content, :summary, :program, :data, {tag_ids: []})
  end
  
  def correct_user
    @code = current_user.codes.find_by(id: params[:id])
    unless @code
      redirect_to root_url
    end
  end
end
