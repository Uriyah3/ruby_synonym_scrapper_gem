require 'synonym_scrapper/datamuse'
require 'synonym_scrapper/educalingo'
require 'synonym_scrapper/nltk'

class SynonymScrapper

  # Define once all dictionaries that can be used
  @@synonym_dictionaries = {
    Datamuse: Datamuse.new,
    Educalingo: Educalingo.new,
    Nltk: Nltk.new
  }

  def synonyms(word, dictionary)
    return "Dictionary does not exist" unless synonym_dictionaries.key?(dictionary)

    return synonym_dictionaries[dictionary].synonyms(word)
  end

  def synonym_dictionaries()
    @@synonym_dictionaries
  end

end
