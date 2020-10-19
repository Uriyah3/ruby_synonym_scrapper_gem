require 'json'
require 'synonym_scrapper/scrapper'

module SynonymScrapper

	##
	# Scrapper for datamuse's API
	
	class Datamuse < Scrapper

		##
		# Initialize the parent Scrapper Class
		
		def initialize()
			super(3, "https://api.datamuse.com/words?v=es&max=40&ml=")
		end

		##
		# Build the url to be called using this class' +base_url+ and a +word+.
		# Returns an url to where +word+'s synonyms can be obtained.
		
		def build_call_url(word)
			URI.parse(base_url + word)
		end

		##
		# Obtain synonyms of a +word+ from Datamuse.
		
		def synonyms(word, options = {})
			response = call(word).read

			synonyms = Array.new
			JSON.parse(response).each do |synonym|
				synonyms.push({
					word: synonym["word"],
					score: synonym["score"]
				})
			end
			return synonyms
		end
	end
end