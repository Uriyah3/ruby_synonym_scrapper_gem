require "synonym_scrapper/version"

require 'synonym_scrapper/datamuse'
require 'synonym_scrapper/educalingo'
require 'synonym_scrapper/nltk'

module SynonymScrapper
  class Error < StandardError; end

  class DictionaryNotAvailable < Error
    def initialize(dictionary = "")
      msg = "The dictionary named #{dictionary.to_s} does not exist in the available dictionaries list"
      super msg
    end
  end

  class WordFormatError < Error
    def initialize(word = "")
      msg = "The word #{word} is not a string, it must be a string."
      super msg
    end
  end

  class SynonymScrapper

    # Define once all dictionaries that can be used
    @@synonym_dictionaries = {
      Datamuse: Datamuse.new,
      Educalingo: Educalingo.new,
      Nltk: Nltk.new
    }

    def synonyms(word, dictionary)
      raise DictionaryNotAvailable, dictionary unless synonym_dictionaries.key?(dictionary)
      raise WordFormatError, word unless word.is_a? String

      return synonym_dictionaries[dictionary].synonyms(word)
    end

    def synonym_dictionaries()
      @@synonym_dictionaries
    end

  end
end