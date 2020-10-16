require_relative 'lib/synonym_scrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "synonym_scrapper"
  spec.version       = SynonymScrapper::VERSION
  spec.authors       = ["Nicolás Mariángel"]
  spec.email         = ["nicolas.mariangel@usach.cl"]

  spec.summary       = %q{Scrapper de sinonimos y antonimos para palabras en español.}
  spec.description   = %q{Gema que permite consultar por sinonimos y antonimos en español desde los sitios: Educalingo, Datamuse y desde la interfaz nltk de python}
  spec.homepage      = "https://rubygems.org/gems/synonym_scrapper"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #s.requirementes << 'Python3 installed to use NLTK'
  spec.metadata["allowed_push_host"] = "https://rubygems.org/gems/synonym_scrapper"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Uriyah3/ruby_synonym_scrapper"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.10"
end
