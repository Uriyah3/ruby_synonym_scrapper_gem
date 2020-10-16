require 'open-uri'
require "test_helper"
require "synonym_scrapper/educalingo"

class EducalingoTest < Minitest::Test
	def setup
  	@educalingo = SynonymScrapper::Educalingo.new
  	@word = "entretenimiento"
	end

  def test_returns_synonyms_of_spanish_word
    mock = Minitest::Mock.new
    def mock.open
      return '<div id="wordcloud1" class="wordcloud">
                <span data-weight="180" style="display: none;">conjunto</span>
                <span data-weight="195" style="display: none;">actividades</span>
                <span data-weight="200" style="display: none;">humanos</span>
                <span data-weight="192" style="display: none;">familia</span>
              </div>'
    end

    URI.stub :open, mock.open do
      synonyms = @educalingo.synonyms(@word)
      refute_empty synonyms
    end
  end

  def test_returns_nothing_for_synonyms_of_english_word
    mock = Minitest::Mock.new
    def mock.open
      raise OpenURI::HTTPError.new('404 Not Found', 404)
    end

    assert_raises OpenURI::HTTPError do
      URI.stub :open, mock.open do
        synonyms = @educalingo.synonyms("latency")
        assert_empty synonyms
      end
    end
  end

  def test_builds_the_correct_uri
  	expected_uri = "https://educalingo.com/en/dic-es/#{@word}"
  	assert_equal @educalingo.build_call_url(@word).to_s, expected_uri
  end
end
