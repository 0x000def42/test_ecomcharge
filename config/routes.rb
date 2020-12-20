get '/posts/top/:limit', to: 'posts#top'
post '/posts', to: 'posts#create'
post '/rates', to: 'rates#create'

get '/posts/intersections', to: 'posts#intersections'