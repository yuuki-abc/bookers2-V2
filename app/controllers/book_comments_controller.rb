class BookCommentsController < ApplicationController
  before_action :ensure_correct_book_comment, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_back(fallback_location: root_path)
  end

   private

      def book_comment_params
        params.require(:book_comment).permit(:comment)
      end

      def ensure_correct_book_comment
        book = Book.find(params[:book_id])
        unless book.user == current_user
        redirect_to books_path
      end
  end

end
