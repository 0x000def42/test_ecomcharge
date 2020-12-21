class RateRepository < Hanami::Repository
  associations do
    belongs_to :post
  end

  def count
    rates.count
  end
end
