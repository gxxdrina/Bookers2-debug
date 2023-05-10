class BooksController < ApplicationController
  #before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    #to = Time.current.at_end_of_day #現在日時を取得して1日の終わりを23:59に設定
    #from = (to - 6.day).at_beginning_of_day #1週間分のデータ 1日の始まりの時刻を0:00に設定
    #@books = Book.includes(:favorited_users).
    #  sort_by {|x|
    #    x.favorited_users.includes(:favorites).where(created_at: from...to).size
    #  }.reverse
    
    #過去1週間のいいね多い順
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort{|a,b|
    b.favorites.where(created_at: from...to).size <=>
    a.favorites.where(created_at: from...to).size
    }
    
    #いいね多い順
    #@books = Post.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user 
      redirect_to books_path
    end
    #unless @book.user == current_user 
    #render 'index'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id]) #いらない
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
