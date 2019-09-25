class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
    
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @records = @user.records.order(id: :desc).page(params[:page]).per(8)
    @sum_contents = @user.records.sum(:content)
      to = Date.today.next_month.beginning_of_month
      from = Date.today.beginning_of_month
    @sum_month_contents = @user.records::where(date: from...to).sum(:content)

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def graph
        @user = User.find(params[:id])
        @sum_contents = @user.records.sum(:content)
      to = Date.today.next_month.beginning_of_month
      from = Date.today.beginning_of_month
    @sum_month_contents = @user.records::where(date: from...to).sum(:content)
    gon.data = []
    gon.data <<  @records = @user.records.sum(:content)  
    gon.data << @user.records::where(date: from...to).sum(:content)
  end
    

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
