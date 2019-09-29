
class ToppagesController < ApplicationController
  def index
    if logged_in?
      @record = current_user.records.build
      @records = Record.all.order(id: :desc).page(params[:page]).per(10)
      

    end
  end
end
