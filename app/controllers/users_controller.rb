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
		user2 = User.find(3)
		if user.geocoded?
				@x = User.near(user.address, 10)
		end
		puts 
		@client = GooglePlaces::Client.new(ENV['google_places_key'])
		# render :text => ENV['google_places_key']
		# @client.spots(user.latitude, user.longitude)
		# render :text => Geocoder.search("library", :location=> {"lat"=> user.latitude, "lng"=>user.longitude})
		lang = (user.latitude).to_s
		long = (user.longitude).to_s
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

	private
	def user_params
		params.require(:user).permit(:name, :alias, :email, :street, :city, :state, :longitude, :latitude, :password, :password_confirmation)
	end

end
