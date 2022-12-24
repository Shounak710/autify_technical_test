class DataFetchService
  def initialize(url:)
    @url = url
  end

  def perform
    URI.open(@url) do |webpage|
      webpage_contents = webpage.read  
      parsed_url = URI.parse(@url)

      File.open("#{parsed_url.host}.html", "w") do |file|
        file.write(webpage_contents)
      end

      webpage_contents
    end
  end
end