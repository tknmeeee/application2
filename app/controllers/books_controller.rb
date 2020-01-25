class BooksController < ApplicationController
	before_action :authenticate_user!
	def show
		@books = Book.find(params[:id])
		@book = Book.new
		@user = current_user
	end

	def index
		@books = Book.all
		@user = current_user
		@book = Book.new
	end

	def new
		@book = Book.new
		@book.user = current_user
	end

	def create
		@book = Book.new(book_params)
		@user = current_user
		@book.user = current_user
		@books = Book.all
		if @book.save
		  flash[:notice] = "You have creatad book successfully."
		  redirect_to book_path(@book)
	    else
		  render :index
		end
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		  flash[:notice] = "You have updated book successfully."
		  redirect_to book_path(@book)
		else
		  render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
