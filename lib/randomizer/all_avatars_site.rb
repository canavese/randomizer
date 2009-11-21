require 'net/http'
require 'nokogiri'

class AllAvatarsSite

  def self.instance
    @@instance ||= AllAvatarsSite.new
  end

  def initialize
    @unused_avatar_urls = []
    @used_avatar_urls = []
  end

  def load_urls
    while @unused_avatar_urls.empty?
      path = "/avatars/showgallery.php?si=&perpage=18&sort=6&cat=all&ppuser="
      response = Net::HTTP.get_response("www.allavatars.com", path).body
      doc = Nokogiri::HTML(response)
      (doc/'img').each do |img|
        source = img['src']
        if source =~ %r{http://www.allavatars.com/avatars/data/.*} && !@used_avatar_urls.member?(source)
          @unused_avatar_urls << source
        end
      end
    end
  end

  def random_url
    load_urls if @unused_avatar_urls.empty?
    url = @unused_avatar_urls.pop
    @used_avatar_urls << url
    url
  end

end