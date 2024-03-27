describe 'HTTPParty' do
  it 'content-type', vcr: {cassette_name: 'jsonplaceholder/posts'} do
    #stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #to_return(status: 200, body: "", headers: {'content-type': 'application/json; charset: utf-8'})

    # VCR.use_cassette("jsonplaceholder/posts") do  usei o vcr acima
      response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
  end
end