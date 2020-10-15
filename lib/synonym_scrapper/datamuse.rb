require 'json'
require 'synonym_scrapper/scrapper'

class Datamuse < Scrapper

	def initialize()
		super(5, "https://api.datamuse.com/words?v=es&max=40&ml=")
	end

	def build_call_url(word)
		URI.parse(base_url + word)
	end

	def synonyms(word)
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