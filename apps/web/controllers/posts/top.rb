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
          status 200, result.map do |post| 
            {
              id: post.id, 
              title: post.title, 
              content: post.content, 
              ip: post.ip, 
              autor: {
                login: post.user.login
              }
            } 
          end
          .to_json 
        end
      end
    end
  end
end