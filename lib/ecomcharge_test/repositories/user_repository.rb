class UserRepository < Hanami::Repository
  associations do
    has_many :posts
  end

  def find_or_create_by_login login
    users.find_or_create_by login: login
  end
end
