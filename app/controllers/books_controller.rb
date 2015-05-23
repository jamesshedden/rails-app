class BooksController < ApplicationController
  def index
    @books = Book.paginate(:page => params[:page], :per_page => 3) 
  end

  def show
    @book = Book.find params[:id]
    @comments = @book.comments
  end

end
