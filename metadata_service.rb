class MetadataService
  METADATA_FILE = "./metadata.yml"

  class << self    
    def fetch(url)
      puts "url: #{url}"
      if File.exists?(METADATA_FILE)
        metadata = YAML.load_file(METADATA_FILE)["#{url}".to_sym]

        if metadata
          puts "site: #{url}"
          puts "num_links: #{metadata[:num_links]}"
          puts "images: #{metadata[:images]}"
          puts "last_fetch: #{metadata[:last_fetch]}"
          puts ""
        else
          puts "#{URI.parse(url)}: no data available"
        end
      else
        puts "#{URI.parse(url)}: no data available"
      end
    end
  end

  def initialize(url:, webpage_content:)
    @url = url
    @webpage_content = webpage_content
  end

  def update
    data = YAML.load_file(METADATA_FILE)
    new_data = data.merge(webpage_metadata)
    File.write(METADATA_FILE, new_data.to_yaml)
  end

  private

  def webpage_metadata
    doc = Nokogiri::HTML(@webpage_content)
    href_elems = doc.css('a[href]')
    img_elems = doc.css('img')

    hash = {
      "#{@url}": {
        num_links: href_elems.map { |e| e["href"] }.count,
        images: img_elems.count,
        last_fetch: Time.now.utc.to_s
      }
    }
  end
end