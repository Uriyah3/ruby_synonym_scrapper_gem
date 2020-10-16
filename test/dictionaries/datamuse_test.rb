require "test_helper"
require "synonym_scrapper/datamuse"

class DatamuseTest < Minitest::Test
	def setup
  	@datamuse = SynonymScrapper::Datamuse.new
  	@word = "entretenimiento"
	end

  def test_returns_synonyms_of_spanish_word
  	mock = Minitest::Mock.new
    def mock.read
    	return '[{"word":"entretención", "score":707359}, {"word":"entretenimientos", "score":651831}]'
    end

    URI.stub :open, mock do
    	synonyms = @datamuse.synonyms(@word)
    	refute_empty synonyms
    end
  end

  def test_returns_nothing_for_synonyms_of_english_word
  	mock = Minitest::Mock.new
    def mock.read
    	return "[]"
    end

    URI.stub :open, mock do
    	synonyms = @datamuse.synonyms("latency")
  		assert_empty synonyms
    end
  end

  def test_builds_the_correct_uri
  	expected_uri = "https://api.datamuse.com/words?v=es&max=40&ml=#{@word}"
  	assert_equal @datamuse.build_call_url(@word).to_s, expected_uri
  end
end
