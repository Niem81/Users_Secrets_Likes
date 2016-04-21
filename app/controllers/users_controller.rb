class UsersController < ApplicationController

	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def index
		redirect_to '/sessions/new'
	end

	def show
		@user = current_user
	end

	def create
  		@user = User.new(user_params)
  		if @user.save
  			#sth
  			log_in @user
  			redirect_to @user
  		else
  			#error
  			flash[:errors] = @user.errors.full_messages
  			redirect_to users_new_path
  		end
	end

	def new
		if not @user
			@user = User.new
		end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
	    if @user.update(user_params)
	      flash[:success] = "User successfully updated"
	      redirect_to @user
	    else
	      flash[:errors] = @user.errors.full_messages
	      redirect_to :back
	    end	
	end

	def destroy
		@user = current_user
		@user.destroy
		redirect_to 'sessions#destroy'
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def update_params
		params.require(:user).permit(:name, :email)
	end
end
