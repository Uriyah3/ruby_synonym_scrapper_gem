require 'open-uri'

module SynonymScrapper
	class Scrapper
		USER_AGENTS = [
	    'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko',
	    'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0',
	    'Mozilla/5.0 (Windows; U; Win 9x 4.90; SG; rv:1.9.2.4) Gecko/20101104 Netscape/9.1.0285',
	    'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0',
	    'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36',
	    'Mozilla/5.0 (Windows; U; Windows NT 6.1; rv:2.2) Gecko/20110201',
	    'Opera/9.80 (Windows NT 6.0) Presto/2.12.388 Version/12.14',
	    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/537.13+ (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2',
	    'Mozilla/5.0 (iPhone; U; ru; CPU iPhone OS 4_2_1 like Mac OS X; ru) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148a Safari/6533.18.5',
	    'Mozilla/5.0 (Linux; U; Android 2.3.4; fr-fr; HTC Desire Build/GRJ22) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1',
	    'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+',
	    'Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1',
	  ]

	  attr_accessor :max_retries
	  attr_accessor :retries_left
	  attr_accessor :base_url

	  def initialize(max_retries, base_url)
	  	@max_retries = max_retries
	  	@retries_left = max_retries
	  	@base_url = base_url
	  end

	  def build_call_url(endpoint)
	  	"define this method in subclasses"
	  end

	  def call(endpoint)
	  	uri = build_call_url(endpoint)
	  	begin
				response = URI.open(uri, 'User-Agent' => USER_AGENTS.sample)
			rescue => e
				puts e
				retry_call endpoint unless retries_left <= 0 
			end
	  	retries_left = max_retries
	  	return response
	  end

	  def retry_call(endpoint)
	  	retries_left -= 1

	  	sleepTime = (50 + rand(950)) / 1000
	  	sleep(sleepTime)

	  	call(endpoint)
	  end
	end
end