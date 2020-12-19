module Web
  module Controllers
    module Posts
      class Create
        include Web::Action
        accept :json

        params do
          required(:title).filled(:str?)
          required(:content).filled(:str?)
          required(:login).filled(:str?)
          required(:ip).filled(:str?)
        end

        def call(params)
          if params.valid?
            post = PostRepository.new.create_with_user(
              title: params[:title], 
              content: params[:content], 
              ip: params[:ip], 
              login: params[:login]
            )
            status 200, {title: post.title, content: post.content, ip: post.ip, user: { login: post.user.login }}
          else
            status 422, params.error_messages.join("\n")
          end
        end
      end
    end
  end
end