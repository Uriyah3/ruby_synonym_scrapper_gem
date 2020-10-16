require "test_helper"
require "synonym_scrapper/nltk"

class NltkTest < Minitest::Test
	def setup
  	@nltk = SynonymScrapper::Nltk.new
  	@word = "entretenimiento"
	end

  def test_returns_synonyms_of_spanish_word
  	synonyms = @nltk.synonyms(@word)
  	refute_empty synonyms
  end

  def test_returns_nothing_for_synonyms_of_english_word
  	synonyms = @nltk.synonyms("latency")
  	assert_empty synonyms
  end
end
