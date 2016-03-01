class LanguagesController < ApplicationController
	def update
		params[:language].each do | x |
			x.to_i
			Ninja.create(user: User.find(session[:user_id]), language: Language.find(x))
		end
		redirect_to '/dashboard/%d' % session[:user_id]
	end
	def destroy
		finished = User.find(session[:user_id]).ninjas.where(language_id: params[:id])
		finished.first.destroy
		redirect_to '/edit' % session[:user_id]
	end
end
