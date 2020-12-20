require_relative '../../../../apps/web/controllers/posts/rate'

RSpec.describe Web::Controllers::Posts::Rate do
  let(:action) { Web::Controllers::Posts::Rate.new }
  let(:params) { 
    {
      value: 5, 
      post_id: PostRepository.new.create_with_user(
        title: "Some title", 
        content: "some content", 
        ip: "255:255:255:255", 
        login: "somelogin"
      ).id
    }
  }

  let(:seed) do
    repo = RateRepository.new
    post = PostRepository.new.create_with_user(
      title: "Some title", 
      content: "some content", 
      ip: "255:255:255:255", 
      login: "somelogin"
    )

    [
      1,2,3,4,5,4,5,4,4
    ].each do |value|
      repo.create(post_id: post.id, value: value)
    end
  end

  let(:result) do
    {rate_avg: 3.55}
  end

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to be(200)
    expect(response[2]).to eq(result)
  end
end