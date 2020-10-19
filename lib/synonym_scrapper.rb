require "synonym_scrapper/version"

require 'synonym_scrapper/datamuse'
require 'synonym_scrapper/educalingo'
require 'synonym_scrapper/nltk'

module SynonymScrapper

  ##
  # Exception thrown by any synonym_scrapper error.

  class Error < StandardError; end

  ##
  # Exception thrown when a wrong dicitonary name is used.

  class DictionaryNotAvailable < Error
    def initialize(dictionary = "")
      msg = "The dictionary named #{dictionary.to_s} does not exist in the available dictionaries list"
      super msg
    end
  end

  ##
  # Exception thrown when the word is not a string.

  class WordFormatError < Error
    def initialize(word = "")
      msg = "The word #{word} is not a string, it must be a string."
      super msg
    end
  end

  ##
  # SynonymScrapper holds the synonym sources to be used and allows making
  # requests to each of these dictionaries by their symbol.
  # 

  class SynonymScrapper

    ##
    # Hash with all dictionaries that can be used. Stored in a class variable.
    #
    # All dictionaries implement the synonyms method.

    @@synonym_dictionaries = {
      Datamuse: Datamuse.new,
      Educalingo: Educalingo.new,
      Nltk: Nltk.new
    }

    ##
    # Getter for the +synonym_dictionaries+ class variable

    def synonym_dictionaries
      @@synonym_dictionaries
    end

    ##
    # Request the synonyms of a +word+ from the selected +dictionary+.
    #
    # A request to all dictionaries available can be made by iterating over the
    # keys in class variable +synonym_dictionaries+
    #
    # A DictionaryNotAvailable is raised if a wrong +dictionary+ key is given.
    # A WordFormatError is raised if +word+ is not a string.

    def synonyms word, dictionary
      raise DictionaryNotAvailable, dictionary unless dictionary_exists?(dictionary)
      raise WordFormatError, word unless word.is_a? String

      return synonym_dictionaries[dictionary.capitalize].synonyms(word)
    end

    ##
    # Checks if the given +dictionary+ symbol is a key in the
    # +synonym_dictionaries+ class variable

    def dictionary_exists? dictionary
      synonym_dictionaries.key?(dictionary.capitalize)
    end
  end
end