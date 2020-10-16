require "test_helper"
require "synonym_scrapper/scrapper"

class ScrapperTest < Minitest::Test
  def test_predefined_user_agents_is_array
    assert_kind_of Array, SynonymScrapper::Scrapper::USER_AGENTS
  end

  def test_predefined_uset_agents_is_not_empty
    refute_empty SynonymScrapper::Scrapper::USER_AGENTS
  end

  def test_build_call_url_method_raises_error_if_not_overwritten
    scrapper = SynonymScrapper::Scrapper.new(3, "http://example.api/")

    assert_raises SynonymScrapper::Error do
      scrapper.build_call_url("endpoint")
    end
  end

  def test_build_call_url_method_can_be_overwritten
    scrapper = SynonymScrapper::Scrapper.new(3, "http://example.api/")
    def scrapper.build_call_url endpoint
      "#{@base_url}#{endpoint[0]}?#{endpoint[1]}=#{endpoint[2]}"
    end

    actual_url = scrapper.build_call_url(["words", "word", "entretenimiento"])
    expected_url = "http://example.api/words?word=entretenimiento"
    assert_equal expected_url, actual_url
  end
end
