require "test_helper"

class SynonymScrapperTest < Minitest::Test
	def setup
		@scrapper = SynonymScrapper::SynonymScrapper.new
		@word = "entretenimiento"
	end

  def test_that_it_has_a_version_number
    refute_nil ::SynonymScrapper::VERSION
  end

  def test_each_dictionary_returns_json_with_synonyms_and_score
    mock = Minitest::Mock.new
    def mock.synonyms(word = "")
      return [{:word => "entretenimiento", :score => 6000}, {:word => "actividades", :score => 5000}]
    end

  	@scrapper::synonym_dictionaries.keys.each do |dictionary|
      real_dictionary = @scrapper::synonym_dictionaries[dictionary]

      @scrapper::synonym_dictionaries[dictionary] = mock
  		response = @scrapper.synonyms(@word, dictionary)
  		refute_empty response

      @scrapper::synonym_dictionaries[dictionary] = real_dictionary
  	end
  end

  def test_raises_error_for_incorrect_dictionary
  	assert_raises SynonymScrapper::DictionaryNotAvailable do
  		@scrapper.synonyms(@word, :rae)
  	end
  end

  def test_raises_error_for_not_capitalized_dictionary
  	assert_raises SynonymScrapper::DictionaryNotAvailable do
  		@scrapper.synonyms(@word, :datamuse)
  	end
  end

  def test_raises_error_when_word_is_not_string
  	assert_raises SynonymScrapper::WordFormatError do
  		@scrapper.synonyms(53, :Datamuse)
  	end
  end
end
