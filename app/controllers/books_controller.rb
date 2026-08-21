class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

   def index
     @books = Book.all
     @book = Book.new
     @user = Current.user
   end

   def new
     @book = Book.new
    
   end

   def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
   end

   def edit
     @book = Book.find(params[:id])
   end

   def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      @user = Current.user
      @books = Book.all
      render :edit, status: :unprocessable_entity
    end
  end
   
   def create
     @book = Book.new(book_params)
     @book.user_id = Current.user.id
     if @book.save
     redirect_to book_path(@book), notice: "You have created book successfully." 

     else
     @user = Current.user
     @books = Book.all
     render :index, status: :unprocessable_entity
    end
  end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
    end

  private

   def book_params
   params.require(:book).permit(:title, :body)
   end

   def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == Current.user.id
      redirect_to books_path
   end
  end
end
