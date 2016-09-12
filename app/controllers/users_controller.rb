class UsersController < ApplicationController
	# before_action :require_login, except: [:new, :create]
	# before_action :require_correct_user, only: [:show]

	def new
		@languages = Language.all
	end

	def create
		user = User.new(user_params)
		if user.valid? == true && params[:language]
			user.save
			session[:user_id] = user.id 
			params[:language].each do | x |
				x.to_i
				Ninja.create(user: User.find(session[:user_id]), language: Language.find(x))
			end		
			redirect_to '/dashboard/%d' % session[:user_id]
		elsif user.valid? == false
			flash[:error] = user.errors.full_messages 
			redirect_to '/new'
		else
			flash[:language_error] = ["Please select language(s)"]
			redirect_to '/new'
		end
	end

	def show	
		user = User.find(session[:user_id])
		@profile =  user
		if user.geocoded?
			@x = User.near(user.address, 10)
			if @x.length <= 1
				flash[:nobody] = "There are no PairCoders currently in your area."
			end
		end
	end

	def edit
		@profile = User.find(session[:user_id])
		@languages = Language.all
	end

	def update
		user = User.find(session[:user_id])
		User.find(session[:user_id]).update(name: params[:name])
		User.find(session[:user_id]).update(email: params[:email])
		User.find(session[:user_id]).update(alias: params[:alias])
		User.find(session[:user_id]).update(street: params[:street])
		User.find(session[:user_id]).update(city: params[:city])
		User.find(session[:user_id]).update(state: params[:state])	
		redirect_to '/dashboard/%d' % session[:user_id]
	end

	def delete
		if(session[:user_id]===10)
			flash[:admin_error] = ["This account cannot be deleted while it is being used for demonstration purposes."]
			redirect_to '/edit' 
		else			
			Ninja.where(user_id:session[:user_id]).destroy_all
			User.find(session[:user_id]).destroy
			session.clear
			redirect_to "/"
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :alias, :email, :street, :city, :state, :longitude, :latitude, :password, :password_confirmation)
	end

end


