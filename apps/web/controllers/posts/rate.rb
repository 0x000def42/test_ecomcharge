module Web
  module Controllers
    module Posts
      class Rate
        include Web::Action

        accept :json

        params do
          required(:post_id).filled(:str?)
          required(:value).filled(:str?)
        end

        def call(params)
          post_repository = PostRepository.new
          rate_repository = RateRepository.new

          post = post_repository.find params[:post_id]
          rate_repository.new.create post: post, value: params[:value]
          post.reload!

          status 201, {rate_avg: post.rage_avg}.to_json
        end
      end
    end
  end
end