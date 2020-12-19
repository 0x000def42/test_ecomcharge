class PostRepository < Hanami::Repository
  associations do
    belongs_to :autor
    has_many :rates
  end

  def top number
    posts.order(:rate_avg).limit(number)
  end

  def intersections
    res = <<-SQL
      select p.ip, u.login
      from posts as p
      join users as u
      on u.id = p.user_id
      where p.ip in (
        select ip, count(distinct user_id) as double_count
        from posts
        group by ip
        having double_count > 1
      )
    SQL
    res.inject({}) { |acc, row|
      (acc[row[:ip]] ||= []) << row[:login]
    }.map { |key, value| {ip: key, logins: value}}
  end
end
