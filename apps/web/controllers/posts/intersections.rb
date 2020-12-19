module Web
  module Controllers
    module Posts
      class DoubledLoginByIp
        include Web::Action

        accept :json

        def call(params)
          result = PostRepository.intersections
          status 201, result.to_json
        end
      end
    end
  end
end