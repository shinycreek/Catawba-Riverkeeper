class CatawbaReleaseAPIService

  def call
    response = Faraday.get('https://lakes.duke-energy.com/Data/flow/1.txt')
    releases = JSON.parse(response.body)
    binding.pry
  end
end
