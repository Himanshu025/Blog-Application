class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token


	def index
	end

	def show
	end

	def create
		@user = User.create(user_params)
		@user.save
		redirect_to users_path
	end

	def checklogin
		@user = user_params
		@users = User.all
		@flag = 1

		@users.each do |users|
			if(users[:email].eql? @user[:email] and users[:password].eql? @user[:password])
				session[:current_user_id] = @user[:id]

				session[:current_user_email] = @user[:email]
				redirect_to articles_path
				@flag = 0 
				break;
			end
		end
		if(@flag ==1)
			redirect_to root_path
		end
	end     

	private
	def user_params
		params.permit(:email,:password)
	end 

end
