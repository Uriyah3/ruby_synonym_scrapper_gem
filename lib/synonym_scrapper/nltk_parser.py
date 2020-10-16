# This script was created using the following tools:
# - Python3
# - nltk (Natural Language Toolkit), installed using pip3
# - From the nltk, wordnet and omw (Open Multilingual Wordnet)

from nltk.corpus import wordnet as wn
import json
import sys

# Everything that can be obtained from the WordNet interface:
#    - Synonyms: words contained within the same WordNet synset (example: ocean → sea)
#    - Hypernyms: "Kind of" (example: gondola → boat)
#    - Hyponyms: "More general than" (example: boat → gondola)
#    - Holonyms: "Comprises" (example: car → accelerator)
#    - Meronyms: "Part of" (example: trunk → tree)
#    - pertainym: "Of or pertaining to" 
#    - Derivationally related forms: Terms in different syntactic categories that have the same root form and are semantically related.

# Configuration
langKey = "spa"
withTypeOfRelation = False

# Function definitions

# Obtain a list of synonyms from a synset, translate the Synset to a
# language specific lemma and then obtain its name only if it is a single word
# Input: array of Synset elements
# Output set of strings containing the translated words 
def synonyms(synList):
    relatedWords = set()
    for relatedWord in synList:
        for lemma in relatedWord.lemmas(lang=langKey):
            name = lemma.name()
            if not '_' in name:
                relatedWords.add(lemma.name())
    return relatedWords

# Obtain a list of related words from a lemma list.
# First it translates the lemma to its language agnostic synset and then
# back to a language specific lemma.
# Input: array of Lemma elements
# Output set of strings containing the related translated words
def get_related_lemmas(lemmaList):
    relatedLemmas = set()
    for lemma in lemmaList:
        for langLemma in lemma.synset().lemmas(lang=langKey):
            name = langLemma.name()
            if not '_' in name:
                relatedLemmas.add(lemma.name())
    return relatedLemmas

def format_synonyms(wordList, relationType):
    results = []
    for word in wordList:
        newWord = {
            'word': word,
            'relation': relationType,
            'score' : 100
        }
        results.append(newWord)
    return results

# Read input and initalize variables
wordList = []

argumentText = sys.argv[1]
fileInput = False
if '.' in argumentText and argumentText[-1] != '.':
    # Then a file is going to be read to get the list of words
    fileInput = True
    wordFile = open(argumentText, 'r')
    for word in wordFile.read().split('\n'):
        wordList.append(word)
    wordFile.close()    
else:
    # Otherwise assume the input is a single word to be processed
    wordList.append(argumentText)

wordRelations = {}
newWordList = set()

# Process each word and write its relations to the final file
for word in wordList:
    lemmas = wn.lemmas(word, lang=langKey);
    synsets = wn.synsets(word, lang=langKey);

    relatedWords = [] 
    relatedWords += format_synonyms(synonyms(synsets), 'synonym')

    for synset in synsets:
        relatedWords += format_synonyms(synonyms(synset.hyponyms()), "hyponym")
        relatedWords += format_synonyms(synonyms(synset.hypernyms()), "hypernym")
        relatedWords += format_synonyms(synonyms(synset.member_holonyms()), "holonym")
        relatedWords += format_synonyms(synonyms(synset.part_meronyms()), "meronym")
        relatedWords += format_synonyms(synonyms(synset.substance_meronyms()), "meronym")
    for lemma in lemmas:
        relatedWords += format_synonyms(get_related_lemmas(lemma.derivationally_related_forms()), "derivationally")
        relatedWords += format_synonyms(get_related_lemmas(lemma.pertainyms()), "pertainym")

    wordRelations[word] = relatedWords

    newWordList.add(word)
    for relatedWord in relatedWords:
        newWordList.add(relatedWord['word'])

# Build output as JSON
jsonData = {
    'words': list(sorted(newWordList)),
    'relations': {}
}
for key, value in wordRelations.items():
    jsonData['relations'][key] = list(map(dict, frozenset(frozenset(i.items()) for i in value)))
print(json.dumps(jsonData))

