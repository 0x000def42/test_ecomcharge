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

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to be(200)
  end
end