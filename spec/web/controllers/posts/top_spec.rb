require_relative '../../../../apps/web/controllers/posts/top'

RSpec.describe Web::Controllers::Posts::Top do
  let(:action) { Web::Controllers::Posts::Top.new }
  let(:params) { {limit: 2} }

  let(:post) {
    -> { 
      PostRepository.new.create_with_user(
        title: "Some title", 
        content: "some content", 
        ip: "255:255:255:255", 
        login: "somelogin"
      ) 
    }
  }

  let(:seed) do
    repo = RateRepository.new
    posts = [post.call, post.call, post.call, post.call]

    posts.each_with_index do |post, i|
      4.times do |j|
        repo.create(post_id: post.id, value: i + 1)
      end
    end
  end

  let(:result) do
    [
      {
        autor: {
        login: "somelogin"
        },
        content: "some content",
        id: 4,
        ip: "255:255:255:255",
        rate_avg: 0.4e1,
        title: "Some title"
      },
      {
        autor: {
          login: "somelogin"
        },
        content: "some content",
        id: 3,
        ip: "255:255:255:255",
        rate_avg: 0.3e1,
        title: "Some title"
      }
    ]
  end

  it "is successful" do
    seed
    response = action.call(params)
    expect(response[0]).to be(200)
    expect(response[2]).to eq(result)
  end
end