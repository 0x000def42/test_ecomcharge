get '/posts/top/:limit', to: 'posts#top'
get '/posts/intersections/:limit', to: 'posts#intersections'
post '/posts', to: 'posts#create'

post '/rates', to: 'rates#create'
