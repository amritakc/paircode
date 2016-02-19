Rails.application.routes.draw do

   get '/' => 'sessions#new'

   post '/session/create' => 'sessions#create'

   post '/user/create' => 'users#create'

  

   get '/new' => 'users#new'

   get '/edit' => 'users#edit'

   patch '/users/:id/update' => 'users#update'

   delete '/users/:id' => 'users#delete'

   delete '/' => 'sessions#delete'

   get '/dashboard/:id' => 'users#show'

end
