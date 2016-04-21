class LikesController < ApplicationController

	before_action :require_login, only: [:create, :destroy]

	def create
  		secret = Secret.find(params[:secret][:id])
  		like = Like.find_by(user: current_user, secret: params[:secret][:id])
  		if not like 
	  		like = Like.create(user: current_user, secret:secret)
  		end
  		redirect_to secrets_path
  	end

  	def destroy
  		like = Like.find_by(user: current_user, secret: params[:secret][:id])
  		like.destroy
  		redirect_to :back
  	end
end
