require_relative '../../../../apps/web/controllers/posts/create'

RSpec.describe Web::Controllers::Posts::Create do
  let(:action) { Web::Controllers::Posts::Create.new }
  let(:params) { {title: "Some title", content: "Some content", login: "Some login", ip: "255:255:255:255"} }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to be(200)
  end
end