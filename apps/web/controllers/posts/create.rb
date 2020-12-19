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
            user = UserRepository.new.find_or_create_by_login params[:login]
            post = PostRepository.create(title: params[:title], content: params[:content], ip: params[:ip], user: user)
            status 200, {title: post.title, content: post.content, ip: ip.ip, user: { login: user.login }}
          else
            status 422, params.error_messages.join("\n")
          end
        end
      end
    end
  end
end