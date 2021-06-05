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
    date = params[:date_search]
    @books = Book.where(created_at: date.in_time_zone.all_day)
  end
  

end
