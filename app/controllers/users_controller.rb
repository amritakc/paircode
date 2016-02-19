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

			if params[:ruby]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:ruby]))
			end
			if params[:python]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:python]))
			end
			if params[:javascript]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:javascript]))
			end
			if params[:java]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:java]))
			end
			if params[:C]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:C]))
			end
			if params[:php]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:php]))
			end
			if params[:ios]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:ios]))
			end
			if params[:sql]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:sql]))
			end
			if params[:Cplus]
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(params[:Cplus]))
			end

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
