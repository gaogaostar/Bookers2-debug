class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    render :comments #render先にjsファイルを指定
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    @book = Book.find(params[:book_id])
    render :comments #render先にjsファイルを指定
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
