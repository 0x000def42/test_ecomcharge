require_relative '../../../../apps/web/controllers/posts/top'

RSpec.describe Web::Controllers::Posts::Top do
  let(:action) { Web::Controllers::Posts::Top.new }
  let(:params) { { limit: 4 } }

  let(:seed) do
    posts = build_list(:post, 6)
    posts.each do |post|
      build_list(:rate, 10, post_id: post.id)
    end
  end

  it "is successful ordering" do
    seed
    response = action.call({limit: 4})
    result = JSON.parse response[2][0]
    array_of_avg = result.map {|res| res["rate_avg"] }
    expect(array_of_avg).to eq(array_of_avg.sort.reverse)
    expect(result.size).to eq(4)
  end

  it "is successful slising" do
    seed
    response = action.call({limit: 2})
    result = JSON.parse response[2][0]
    expect(result.size).to eq(2)
  end
end