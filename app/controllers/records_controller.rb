class RecordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :update]
  def create
    @record = current_user.records.build(record_params)
    if @record.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @records = current_user.records.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @record.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @record = Record.find(params[:id])
  end
  
  def update
    @record = Record.find(params[:id])

    if @record.update(record_params)
      flash[:success] = '記録は正常に更新されました'
      redirect_to "/"
    else
      flash.now[:danger] = '記録は更新されませんでした'
      render :edit
    end
  end
    
  private

  def record_params
    params.require(:record).permit(:content, :date, :img, :remove_img)
  end
  
  def correct_user
    @record = current_user.records.find_by(id: params[:id])
    unless @record
      redirect_to root_url
    end
  end
end
