class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    book_comment = BookComment.new(book_comment_params)
    book_comment.user_id = current_user.id #誰がコメントしたのか
    book_comment.book_id = @book.id #コメントと投稿の紐付け
    book_comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id] ).destroy
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end  
end
