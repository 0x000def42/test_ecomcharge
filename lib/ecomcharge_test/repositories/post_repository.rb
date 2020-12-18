class PostRepository < Hanami::Repository
  associations do
    belongs_to :autor
    has_many :rates
  end
end
