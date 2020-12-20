module Web
  module Controllers
    module Rates
      class Create
        include Web::Action

        accept :json

        params do
          required(:post_id).filled(:int?)
          required(:value).filled(:str?)
        end

        def call(params)
          post_repository = PostRepository.new
          rate_repository = RateRepository.new

          post = post_repository.find params[:post_id]
          rate_repository.create post_id: post.id, value: params[:value]
          post = post_repository.find params[:post_id]

          status 200, {rate_avg: post.rate_avg}
        end
      end
    end
  end
end