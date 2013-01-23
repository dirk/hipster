# Hipster

Hipster extracts interesting metadata from URLs. It knew about that website before it was cool.

## Usage

TODO: Write usage instructions here

## Items to Complete:

* IMDB Parser
  * IMDB Parser still needs to handle the following fields:
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
    * Misc:
    	* Actors (key/value pair of Actor Name => Roles)
    	* Episodes (for television series). Do We break these down by season, or just list them all as a giant array?
    		* URL to start with: http://www.imdb.com/title/tt0436992/episodes
	* IMBD also stores information about games and television shows. Our parser should try to detect the differences.
  * Maybe used their JSON API? https://github.com/richardasaurus/imdb-pie
* Wikipedia Parser
  * Wikipedia Parser still needs to handle the following fields:
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
