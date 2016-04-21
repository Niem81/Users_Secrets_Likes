class SecretsController < ApplicationController

	before_action :require_login, only: [:index, :create, :destroy]

  def index
  		@secrets = Secret.all
  end
  def create
  	@user = current_user
  	@user.secrets.create(content: params[:secret][:content])
  	redirect_to @user
  end
  def destroy
  	secret = Secret.find(params[:id])
  	secret.destroy if secret.user == current_user
  	redirect_to current_user#@user
  end



end
