require_relative '../../../../apps/web/controllers/rates/create'

RSpec.describe Web::Controllers::Rates::Create do
  let(:action) { Web::Controllers::Rates::Create.new }
  let(:post) { build(:post) }
  let(:params) {
    {
      value: build(:rate_value),
      post_id: post.id
    }
  }

  it "is successful" do
    response = action.call(params)
    result = JSON.parse response[2][0]
    expect(response[0]).to be(200)
    expect(result.symbolize_keys).to eq({rate_avg: params[:value].to_f})
  end
end