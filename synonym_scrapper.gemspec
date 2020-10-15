Gem::Specification.new do |s|
  s.name        = 'synonym_scrapper'
  s.version     = '0.0.0'
  s.licenses       = ['MIT']
  s.date        = '2020-10-12'
  s.summary     = "Scrapper de sinonimos y antonimos para palabras en español"
  s.description = "Gema que permite consultar por sinonimos y antonimos desde los sitios: Educalingo, Datamuse y desde la interfaz nltk de python"
  s.authors     = ["Nicolás Mariángel"]
  s.email       = 'nicolas.mariangel@usach.cl'
  s.files       = ["lib/synonym_scrapper.rb", "lib/Dictionary.rb", "lib/dictionaries/Datamuse.rb", "lib/dictionaries/Educalingo.rb", "lib/dictionaries/NLTK.rb"]
  s.homepage    = 'https://rubygems.org/gems/synonym_scrapper'
  s.metadata    = { "source_code_uri" => "https://github.com/Uriyah3/ruby_synonym_scrapper" }

  #s.requirementes << 'Python3 installed to use NLTK'
  #s.add_runtime_dependency "daemons", ["= 1.1.0"]
  #s.add_runtime_dependency "daemons", ["~> 1.1"] Greater or equal to but lower than 2.0
  #s.add_development_dependency "bourne", [">= 0"]
end