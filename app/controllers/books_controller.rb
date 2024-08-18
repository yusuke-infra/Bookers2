class BooksController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @book = Book.find(params[:id])
  end

  def new
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def edit
  end
  
  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
