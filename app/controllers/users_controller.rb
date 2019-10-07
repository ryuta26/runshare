class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:update, :edit]
    
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
      month_to = Date.today.next_month.beginning_of_month
      month_from = Date.today.beginning_of_month
      @sum_month_contents = @user.records::where(date: month_from...month_to).sum(:content)
      week_to = Date.today.next_week.beginning_of_week
      week_from = Date.today.beginning_of_week
      @sum_week_contents = @user.records::where(date: week_from...week_to).sum(:content)
    gon.bardata = []
    gon.linedata = []
    
    gon.bardata <<  @records = @user.records.sum(:content)  
    gon.bardata << @user.records::where(date: month_from...month_to).sum(:content)
    gon.bardata << @user.records::where(date: week_from...week_to).sum(:content)
  end
    
    def edit
      @user = User.find(params[:id])
    end
  
  def update
    @user = User.find(params[:id])
    @birthday = @user.birthday
    

    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした'
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthday, :profile)
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user 
  end
  
end