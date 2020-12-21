require_relative '../../../../apps/web/controllers/posts/intersections'

RSpec.describe Web::Controllers::Posts::Intersections do
  let(:action) { Web::Controllers::Posts::Intersections.new }
  let(:params) { Hash[] }
  let(:seed) do
    # Create common post
    build(:post)

    # Create four posts with pair of intersection ips and logins
    user_ids = build_list(:user, 2).map(&:id)
    post_ips = build_list(:post_ip, 2)
    
    user_ids.each do |user_id|
      post_ips.each do |post_ip|
        build(:post, user_id: user_id, ip: post_ip)
      end
    end

  end

  it "is successful" do
    seed
    response = action.call(params)
    result = JSON.parse response[2][0]
    expect(result.size).to be(2)
    expect(result[0]["logins"].size).to eq(2)
  end
end