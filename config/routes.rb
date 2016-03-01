Rails.application.routes.draw do

   get '/' => 'sessions#new'

   post '/session/create' => 'sessions#create'

   post '/user/create' => 'users#create'

  

   get '/new' => 'users#new'

   get '/edit' => 'users#edit'

   patch '/users/:id/update' => 'users#update'

   patch '/users/:id/update_language' => 'users#update_language'

   delete '/users/:id' => 'users#delete'

   delete '/' => 'sessions#delete'

   get '/dashboard/:id' => 'users#show'

end
