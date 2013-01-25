# Hipster

Hipster extracts interesting metadata from URLs. It knew about that website before it was cool.

## Usage

TODO: Write usage instructions here

## Items to Complete

* IMDB Module
  * Movie Parser
    * Dublin Core
      * <del>contributor</del>
      * coverage (Not applicable?)
      * <del>format</del> (length)
      * language
      * <del>publisher</del>
      * <del>relation</del>
      * <del>rights</del>
      * <del>source</del>
      * <del>subject</del>
    * Open Graph
      * <del>image</del>
  * Actors Parser
  * TV Series/Show Parser (Include method for fetching episodes?)
  * Episodes Parser (for television series)
    * Example URL: http://www.imdb.com/title/tt0436992/episodes
	* Video Game Parser
  * Maybe used their JSON API? https://github.com/richardasaurus/imdb-pie
* Wikipedia :movie Parser
  * Still needs to handle the following fields:
    * Dublin Core
      * <del>contributor</del>
      * coverage
      * <del>format</del> (length)
      * language
      * <del>publisher</del>
      * <del>relation</del>
      * <del>rights</del>
      * <del>source</del>
      * <del>subject</del>
* Media Types that still need to be considered:
  * Television
    * Need to determine what to do about television episodes
  * Books
  * Music
  * Videogames (MobyGames?)
* Write more test cases (different types of media/titles)
* Double check our metadata types. I think OG is lacking some of the more detailed ones.
* Migrate Wikipedia parser into module/parser layout like IMDb.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
