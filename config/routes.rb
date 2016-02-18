Rails.application.routes.draw do

   get '/' => 'sessions#new'

   post '/session/create' => 'sessions#create'

   post '/user/create' => 'users#create'

   get '/dashboard/:id' => 'users#show'

   get '/new' => 'users#new'

   delete '/' => 'sessions#delete'

end
