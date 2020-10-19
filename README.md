# SynonymScrapper

Synonym Scrapper is a ruby gem that obtains spanish synoynms from various sources. Currently three synonym sources are supported:
* Datamuse API ([link](https://www.datamuse.com/api/))
* Educalingo dictionary ([link](https://educalingo.com/en/dic-es))
* Natural Language Toolkit ([link](https://www.nltk.org/))

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'synonym_scrapper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install synonym_scrapper

### Using NLTK

First you need to have Python3 installed on the machine that will use this gem. Then you need to install NLTK:

    $ pip3 install nltk

And download its data through python (you can run these through the python interpreter):

```python
import nltk
nltk.download()
```
From the packages available in NLTK you'll need to download omw (Open Multilingual Wordnet).

## Usage

To use this gem you first need to require it:

```ruby
require 'synonym_scrapper'
```

Then you need to create a SynonymScrapper instance and request synonyms from it using one of the dictionaries available. Example:

```ruby
scrapper = SynonymScrapper::SynonymScrapper.new

scrapper.synonyms("entretenimiento", :datamuse)
scrapper.synonyms("saltar", :educalingo)
scrapper.synonyms("auto", :nltk)
```

Data obtained is an array of hashes containing the keys `:word` and `:score`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## To do

- [ ] Implement more synonym sources
- [ ] Use datamuse's API full capabilities
- [ ] Filter data obtained from dictionaries by score
- [ ] Add method to get synonyms from all dictionaries
- [ ] Extend to more languages

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
