require 'nokogiri'
require 'synonym_scrapper/scrapper'

module SynonymScrapper

	##
	# Scrapper for Educalingo's website
	
	class Educalingo < Scrapper

		##
		# Initialize the parent Scrapper Class
		
		def initialize()
			super(5, "https://educalingo.com/en/dic-es/")
		end

		##
		# Build the url to be called using this class' +base_url+ and a +word+.
		# Returns an url to where +word+'s synonyms can be obtained.
		
		def build_call_url(word)
			URI.parse(URI.escape(base_url + word))
		end

		##
		# Obtain synonyms of a +word+ from Educalingo.
		
		def synonyms(word, options = {})
			response = call(word)
			doc = Nokogiri.HTML(response)
			synonyms = Array.new
			doc.css('#wordcloud1 > span').each do |synonym|
				score = Integer(synonym.values[0])

				synonyms.push({
					word: synonym.inner_html,
					score: score
				}) unless score < 75
				# A minimum score of 75 is considered because educalingo
				# tends to have completely unrelated words around this score
			end

			return synonyms
		end

	end
end