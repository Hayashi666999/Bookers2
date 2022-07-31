class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]

  def top
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def edit
    @books = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), flash: { notice: 'You have created book successfully.' }
    else
    @user = current_user
    @books = Book.all
      render :index
    end
  end

  def update
        @books = Book.find(params[:id])
    if @books.update(books_params)
    redirect_to book_path(@books.id)
    flash[:notice] = "You have updated book successfully."
    else
   render :edit
    end
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end


  private

  def books_params
    params.require(:book).permit(:title, :body)
  end
end