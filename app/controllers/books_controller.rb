class BooksController < ApplicationController
  def show
  end

  def new
  end

  def index
    @user = User.find(current_user.id)
  end

  def edit
  end
end
