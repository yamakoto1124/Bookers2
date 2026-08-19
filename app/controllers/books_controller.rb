class BooksController < ApplicationController
  
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
   
   def create
     @book = Book.new(book_params)
     @book.user_id = Current.user.id
     if @book.save
     redirect_to book_path(@book), notice: "Welcome! You Have signed up successfully." 

     else
     @user = current_user
     @books = Book.all
     render :index 
   end
 end

 private

 def book_params
   params.require(:book).permit(:title, :body)
 end
end
