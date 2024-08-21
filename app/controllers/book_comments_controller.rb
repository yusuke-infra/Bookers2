class BookCommentsController < ApplicationController
    
    def create
        book = Book.find(params[:book_id])
        comment = current_user.book_comments.new(book_comment_params)  # comment.user.id = current_user.idとなる
        comment.book_id = book.id
        unless comment.save
            flash_with_error(comment)
        end
        redirect_to book_path(book.id)
    end
    
    def destroy
        book = Book.find(params[:book_id])
        comment = book.book_comments.find(params[:id])
        if comment.user == current_user
            comment.destroy
        end
        redirect_to book_path(book.id)
    end
    
    private
        def book_comment_params
            params.require(:book_comment).permit(:comment)
        end
        
        def flash_with_error(comment)
          flash[:error] = "#{comment.errors.count} error".pluralize + " prohibited this comment from begin saved:"
          flash[:error_messages] = comment.errors.full_messages
        end
end
