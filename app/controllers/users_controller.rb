class UsersController < ApplicationController
	# before_action :require_login, except: [:new, :create]
	# before_action :require_correct_user, only: [:show]

	def new
		@languages = Language.all
	end

	def create
		user = User.new(user_params)
		if user.valid? == true
			user.save
			session[:user_id] = user.id 

			if params[:language]
				params[:language].each do | x |
					x.to_i
					Ninja.create(user: User.find(session[:user_id]), language: Language.find(x))
				end
			end
			redirect_to '/dashboard/%d' % session[:user_id]
		else
			flash[:error] = user.errors.full_messages
			redirect_to '/new'
		end
	end

	def show
		
		user = User.find(session[:user_id])
		@profile =  user
		if user.geocoded?
				@x = User.near(user.address, 10)
				# @languages = Ninja.select("*").joins(:user).joins(:language).where("user_id=?", User.find(@x.id))
		end
	
		# @client = GooglePlaces::Client.new(ENV['google_places_key'])
		# render :text => ENV['google_places_key']
		# @client.spots(user.latitude, user.longitude)
		# render :text => Geocoder.search("library", :location=> {"lat"=> user.latitude, "lng"=>user.longitude})
		# lang = (user.latitude).to_s
		# long = (user.longitude).to_s
		# render :text => Geocoder.search("Starbucks", :bounds => [[user.latitude, user.longitude], [user2.latitude, user2.longitude]])
		# render :text => Geocoder.spots(:bounds => [[user.latitude, user.longitude], [user2.latitude, user2.longitude]])
		# render :text => 


			# {user.latitude, user.longitude})
		# @client.spots_by_query('Pizza near Miami Florida')
		# render :text => @client.spots(-33.8670522, 151.1957362, :types => ['restaurant','food'])
		# render :text => Hotel.near(”Vancouver, Canada”)
		# render :text => Location.near([user.latitude, user.longitude], 1)
		# render :text => Restaurants.near("Rehoboth Beach, DE, US", 50)
		# Geocoder.search("Paris", :bounds => [[32.1,-95.9], [33.9,-94.3]])

		
		# Restaurants.near("Rehoboth Beach, DE, US", 50)
		# Restaurants.near("Rehoboth Beach, DE, US", 50)
		# Place.near("statue of liberty").where(tags: [:hotel]).all
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
		User.find(session[:user_id]).destroy
		# session.clear
		redirect_to "/"
	end

	private
	def user_params
		params.require(:user).permit(:name, :alias, :email, :street, :city, :state, :longitude, :latitude, :password, :password_confirmation)
	end

end

# <select multiple='multiple' name = "language[]">
# 		<option value = 'ruby'>Ruby/Rails</option>
# 		<option value = 'python'>Python</option>
# 		<option value = 'javascript'>JavaScript</option>
# 		<option value = 'java'>Java</option>
# 		<option value = 'C'>C#</option>
# 		<option value = 'php'>PHP</option>
# 		<option value = 'ios'>Ios</option>
# 		<option value = 'sql'>SQL</option>
# 		<option value = 'ruby'>C++</option>
	
# 	</select>	
