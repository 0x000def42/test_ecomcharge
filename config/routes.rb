get '/posts/top/:limit', to: 'posts#top'
post '/posts', to: 'posts#create'
post '/posts/:id/rates', to: 'posts#rate'

get '/posts/intersections', to: 'posts#intersections'