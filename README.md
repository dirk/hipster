# Hipster

Hipster extracts interesting metadata from URLs. It knew about that website before it was cool.

## Usage

TODO: Write usage instructions here


## Items to Complete:

* IMDB Parser.
  * IMDB Parser still needs to handle the following fields:
    * DublinCore
      * contributor
      * coverage (Not applicable?)
      * format (length)
      * language
      * publisher
      * relation
      * rights
      * source
      * subject
    * Open Graph
      * image
* Wikipedia Parser
  * Wikipedia Parser still needs to handle the following fields:
    * contributor
    * coverage
    * format
    * language
    * publisher
    * relation
    * rights
    * source
    * subject
* Media Types that still need to be considered:
  * Television
    * Need to determine what to do about television episodes
  * Books
  * Music
  * Videogames (MobyGames?)
* Write more test cases (different types of media/titles)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
