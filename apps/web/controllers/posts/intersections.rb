module Web
  module Controllers
    module Posts
      class Intersections
        include Web::Action

        accept :json

        def call(params)
          result = PostRepository.new.intersections
          status 200, result.to_json
        end
      end
    end
  end
end