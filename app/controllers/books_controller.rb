class BooksController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index
    @books = Book.paginate(:page => params[:page], :per_page => 3) 
  end

  def show
    @book = Book.find params[:id]
    @comments = @book.comments
  end

  def new
    @book = Book.new
  end
   
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    @book = Book.find params[:id]
  end
   
  def update
    @book = Book.find params[:id]
    if @book.update_attributes(book_params)
      redirect_to @book
    else
      render :edit
    end
  end
   
  def destroy
    book = Book.find params[:id]
    book.destroy
    redirect_to books_path
  end

  def book_params
    params.require(:book).permit(:title, :thoughts)
  end

  private
  def login_required
    unless current_admin
      redirect_to books_path
    end
  end

end
