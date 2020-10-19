require 'json'

module SynonymScrapper

	##
	# Connector and requester of python's NLTK

	class Nltk

		##
		# Obtain synonyms of a +word+ from the NLTK.
		#
		# Makes a call to a python script and parses its results. 
		
		def synonyms(word, options = {})

			begin
				nltk_response = `python3 #{__dir__}/nltk_parser.py "#{word}"`
				related_words = JSON.parse(nltk_response)["relations"][word]

				synonyms = Array.new
				related_words.each do |synonym|
					synonyms.push({
						word: synonym["word"],
						score: synonym["score"]
					})
				end
				return synonyms
			rescue => e
				puts e
				return []
			end
		end

	end
end