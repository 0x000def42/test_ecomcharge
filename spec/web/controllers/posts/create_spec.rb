require_relative '../../../../apps/web/controllers/posts/create'

RSpec.describe Web::Controllers::Posts::Create do
  let(:action) { Web::Controllers::Posts::Create.new }
  let(:params) { build(:post_create_params) }
  let(:result) do
    {
      content: params.content, 
      ip: params.ip, 
      title: params.title, 
      user: {
        login: params.login
      }
    }
  end

  it "is successful" do
    response = action.call(params.to_h)
    expect(response[0]).to be(200)
    expect(JSON.parse response[2][0]).to eq(result.deep_stringify_keys)
  end
end