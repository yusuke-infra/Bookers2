class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy, :new]
  before_action :is_logged_in?
  
  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
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
      flash.now[:error] = "#{@book.errors.count} error".pluralize + " prohibited this book from begin saved:"
      flash.now[:error_messages] = @book.errors.full_messages
    end
    
    def is_matching_login_user
      book = Book.find(params[:id])
      user = book.user
      # ログインユーザーでないなら、showページに飛ばす
      if !user_signed_in?
        redirect_to new_user_session_path
      elsif user.id != current_user.id
        redirect_to books_path
      end
    end
    
    def is_logged_in?
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
