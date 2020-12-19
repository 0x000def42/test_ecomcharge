require_relative '../../../../apps/web/controllers/posts/intersections'

RSpec.describe Web::Controllers::Posts::Intersections do
  let(:action) { Web::Controllers::Posts::Intersections.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to be(200)
  end
end