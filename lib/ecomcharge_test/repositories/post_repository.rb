class PostRepository < Hanami::Repository
  associations do
    belongs_to :user
    has_many :rates
  end

  def top number
    posts.read(
      <<-SQL
        select p.*, u.login as login from posts as p
        join users as u
        on u.id = p.user_id
        order by rate_avg desc
        limit #{number}
      SQL
    ).map {|e| e}
  end

  def count
    posts.count
  end

  def create_with_user params
    user = UserRepository.new.find_or_create_by_login(params[:login])
    post_id = create(
      title: params[:title], 
      content: params[:content], 
      ip: params[:ip], 
      user_id: user.id
    ).id
    aggregate(:user).where(id: post_id).map_to(Post).one
  end

  def intersections limit
    posts.read(
      <<-SQL
        select i.ip, u.login from intersections as i
        join users as u
        on u.id = i.user_id
        where ip IN (
          select ip from intersections as i
          group by ip
          having count(*) > 1
            limit #{limit}
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
