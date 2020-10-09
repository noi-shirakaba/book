class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @book = Book.where(user_id: current_user.id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(
      title: book_params[:title], 
      author: book_params[:author], 
      label: book_params[:label],
      user_id: current_user.id
    )
    if @book.save
      redirect_to('/books')
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if current_user.id == @book.user_id
      if @book.update(book_params)
        redirect_to "/books/#{@book.id}/edit"
      else
        redirect_to "/books/#{@book.id}/edit"
      end
    else
      redirect_to('/')
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if current_user.id == @book.user_id
      if Book.destroy(@book.id)
        redirect_to "/books"
      else
        redirect_to "/books/#{@book.id}/edit"
      end
    else
      redirect_to "/"
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :author, :label)
    end
end
