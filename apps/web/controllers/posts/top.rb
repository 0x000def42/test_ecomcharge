module Web
  module Controllers
    module Posts
      class Top
        include Web::Action

        accept :json

        params do
          required(:limit).filled(:number?)
        end

        def call(params)
          result = PostRepository.new.top params[:limit]
          res = result.map do |post|
            {
              id: post.id, 
              title: post.title, 
              content: post.content, 
              ip: post.ip,
              rate_avg: post.rate_avg,
              autor: {
                login: post.user.login
              }
            } 
          end
          # status 200, res
          status 200, res.to_json

        end
      end
    end
  end
end