class SearchController < ApplicationController

  def search
    @range = params[:range]

    search = params[:search]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(search, @word)
    else
      @books = Book.looks(search, @word)
    end
  end
  
  def date_search
    if params[:date_search] == ""
      @books = "日付を選択してください"
    else
      date = params[:date_search]
      @books = Book.where(created_at: date.in_time_zone.all_day).count
      # 以下解答例
      # create_at = params[:created_at]
      # @books = Book.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end
  

end
