require_relative '../../../../apps/web/controllers/rates/create'

RSpec.describe Web::Controllers::Rates::Create do
  let(:action) { Web::Controllers::Rates::Create.new }
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
    expect(response[2]).to eq({rate_avg: 5})
  end
end