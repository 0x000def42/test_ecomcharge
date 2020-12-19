require_relative '../../../../apps/web/controllers/posts/top'

RSpec.describe Web::Controllers::Posts::Top do
  let(:action) { Web::Controllers::Posts::Top.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to be(200)
  end
end