class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.where(created_at: Date.today.all_day).count
    @yesterday_book = @books.where(created_at: 1.day.ago.all_day).count
    @this_week_book = @books.where(created_at: Date.today.all_week).count
    @last_week_book = @books.where(created_at: 1.week.ago.all_week).count
      # 以下解答例
      # @today_book =  @books.created_today
    @two_days_ago_book = @books.where(created_at: 2.days.ago.all_day).count
    @three_days_ago_book = @books.where(created_at: 3.days.ago.all_day).count
    @four_days_ago_book = @books.where(created_at: 4.days.ago.all_day).count
    @five_days_ago_book = @books.where(created_at: 5.days.ago.all_day).count
    @six_days_ago_book = @books.where(created_at: 6.days.ago.all_day).count
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
    @users = User.find(params[:id]).following.where.not(id: current_user.id)
  end

  def followers
    @users = User.find(params[:id]).followers.where.not(id: current_user.id)
  end
  

  
  

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
  
    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
  end
end
