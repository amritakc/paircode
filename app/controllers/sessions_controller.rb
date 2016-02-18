class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			session[:name] = user.name
			redirect_to '/dashboard/%d' % session[:user_id]
		else
			flash[:errors] = 'Invalid email or password'
			redirect_to '/'
		end

	end

	def delete
		session[:user_id] = nil
		redirect_to '/'
	end
end
