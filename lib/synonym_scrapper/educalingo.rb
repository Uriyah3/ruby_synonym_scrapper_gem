require 'nokogiri'
require 'synonym_scrapper/scrapper'

module SynonymScrapper
	class Educalingo < Scrapper

		def initialize()
			super(5, "https://educalingo.com/en/dic-es/")
		end

		def build_call_url(word)
			URI.parse(base_url + word)
		end

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