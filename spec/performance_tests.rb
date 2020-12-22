describe "GET /posts/top/100" do

  context "Simple query" do
    it "Valid response time" do
      expect { RestClient.get "localhost:8080/posts/top/100" }.to perform_under(20).ms.sample(30)
    end
  end

end

describe "GET /posts/intersections" do

  context "Simple query" do
    it "Valid response time" do
      expect { RestClient.get "localhost:8080/posts/intersections/10" }.to perform_under(20).ms.sample(30)
    end
  end

end
