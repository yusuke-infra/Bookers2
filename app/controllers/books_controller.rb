class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @user = @book.user
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
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      flash_with_error
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      flash_with_error
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
    
    def flash_with_error
      flash.now[:alert] = "#{@book.errors.count} error".pluralize + " prohibited this book from begin saved:"
      flash.now[:error_messages] = @book.errors.full_messages
    end
end
