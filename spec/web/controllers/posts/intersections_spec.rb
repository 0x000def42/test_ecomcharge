require_relative '../../../../apps/web/controllers/posts/intersections'

RSpec.describe Web::Controllers::Posts::Intersections do
  let(:action) { Web::Controllers::Posts::Intersections.new }
  let(:params) { Hash[] }
  let(:seed) do
    repo = PostRepository.new
    repo.create_with_user(login: 'login1', title: 'Title1', content: 'Content1', ip: '255.255.255.0')
    repo.create_with_user(login: 'login1', title: 'Title1', content: 'Content1', ip: '0.255.255.0')
    repo.create_with_user(login: 'login2', title: 'Title1', content: 'Content1', ip: '0.255.255.0')
    repo.create_with_user(login: 'login2', title: 'Title1', content: 'Content1', ip: '255.255.255.0')
    repo.create_with_user(login: 'login3', title: 'Title1', content: 'Content1', ip: '255.0.255.0')
    repo.create_with_user(login: 'login3', title: 'Title1', content: 'Content1', ip: '255.0.255.0')
  end

  let(:result) do
    [
      {:ip=>"0.255.255.0", :logins=>["login1", "login2"]},
      {:ip=>"255.255.255.0", :logins=>["login1", "login2"]}
    ]
  end

  it "is successful" do
    seed
    response = action.call(params)
    expect(response[0]).to be(200)
    expect(response[2]).to eq(result)
  end
end