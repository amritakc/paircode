class UsersController < ApplicationController
	# before_action :require_login, except: [:new, :create]
	# before_action :require_correct_user, only: [:show]

	def new
	end

	def create
		user = User.new(user_params)
		if user.valid? == true
			user.save
			session[:user_id] = user.id 
			redirect_to '/dashboard/%d' % session[:user_id]
		else
			flash[:error] = user.errors.full_messages
			redirect_to '/new'
		end
	end

	def show
		user = User.find(session[:user_id])
		if user.geocoded?
				@x = User.near(user.address, 10)


		end
		
	end

	private
	def user_params
		params.require(:user).permit(:name, :alias, :email, :street, :city, :state, :longitude, :latitude, :password, :password_confirmation)
	end

end
