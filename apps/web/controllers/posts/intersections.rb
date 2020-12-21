module Web
  module Controllers
    module Posts
      class Intersections
        include Web::Action

        accept :json

        params do
          required(:limit).filled(:number?)
        end

        def call(params)
          result = PostRepository.new.intersections params[:limit] || 10
          status 200, result.to_json
        end
      end
    end
  end
end