class FavoritesController < ApplicationController
    
    def create
        book = Book.find(params[:book_id])
        # if book.user.id != current_user.id  # 自分自身の投稿にはいいね出来ない
        favorite = current_user.favorites.new(book_id: book.id)
        favorite.save
        # end
        redirect_back fallback_location:root_path
    end
    
    def destroy
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: book.id)
        favorite.destroy
        redirect_back fallback_location:root_path
    end
end
