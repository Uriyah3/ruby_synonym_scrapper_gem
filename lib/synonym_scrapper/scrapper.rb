require 'open-uri'

module SynonymScrapper

	##
	# Base scrapper used to scrape APIs/websites

	class Scrapper

		##
		# List of user agents to select from when scraping.
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

		##
		# Number, denotes the maximum number of retries to do for each failed request.
	  attr_accessor :max_retries

		##
		# Number, denotes how many more retries will be done for a request.
	  attr_accessor :retries_left

		##
		# Base url of the API/website to be consulted.
	  attr_accessor :base_url

		##
		# Initilalize the scrapper with the +base_url+ to scrape and the maximum
		# number of retries, +max_retries+

	  def initialize max_retries, base_url
	  	@max_retries = max_retries
	  	@retries_left = max_retries
	  	@base_url = base_url
	  end

		##
		# Method to be overwritten by classes that inherit from this one
		# endpoint can be anything [Array, Hash, String, etc] as long as
		# it is used consistently in the child class.

	  def build_call_url endpoint
	  	raise Error, "This method must be redefined in subclasses"
	  end

		##
		# Executes a call to the given +endpoint+ and returns its response.
		#
		# In case of HTTP Error, method will retry +@max_retries+ times.
		# In case of a 404 response, then it will be assumed that retrying 
		# would be useless and an empty array is returned.
		# No retrying is done for other types of errors.

	  def call endpoint
	  	uri = build_call_url(endpoint)
			begin
				response = URI.open(uri, 'User-Agent' => USER_AGENTS.sample)
			rescue OpenURI::HTTPError => e
				puts e
				return [] if e.message == '404 Not Found'
				retry_call endpoint unless @retries_left <= 0 
			rescue => e
				puts e
			end
			# Reset the retries_left variable on this instance after each request
	  	@retries_left = @max_retries
	  	return response
	  end

		##
		# Retry the call to the +endpoint+ specified after a waiting between
		# 50 and 1000 milliseconds (random sleep)

	  def retry_call endpoint
	  	@retries_left -= 1

	  	sleepTime = (50 + rand(950)) / 1000
	  	sleep(sleepTime)

	  	call(endpoint)
	  end
	end
end