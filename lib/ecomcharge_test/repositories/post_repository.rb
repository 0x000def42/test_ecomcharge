class PostRepository < Hanami::Repository
  associations do
    belongs_to :user
    has_many :rates
  end

  def top number
    posts.order(:rate_avg).limit(number)
  end

  def create_with_user params
    user = UserRepository.new.find_or_create_by_login(params[:login])
    aggregate(:user).where(id: user.id).map_to(Post).one
    post_id = create(
      title: params[:title], 
      content: params[:content], 
      ip: params[:ip], 
      user_id: user.id
    ).id
    aggregate(:user).where(id: post_id).map_to(Post).one
  end

  def intersections
    posts.read(
      <<-SQL
        select p.ip, u.login
        from posts as p
        join users as u
        on u.id = p.user_id
        where EXISTS (
          select ip
          from posts
          group by ip
          having count(distinct user_id) > 1
        )
      SQL
      ).map {|e| e}
      .inject({}) { |acc, post|
        ip = post[:ip]
        unless acc[ip]
          acc[ip] = []
        end
        acc[ip] << post[:login]
        acc
    }.map { |key, value| {ip: key, logins: value}}
  end
end
