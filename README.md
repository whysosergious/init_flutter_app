# init_flutter_app

A new Flutter application.

Well, there's a lot to unpack here.. and basically an unfinished project..
As a learning experience I do consider to have grasped a good level of the language and the framework.
I didn't want to drag out the test and feel I have to deliver an unfinished product.
Estimated time until full completion ca 1-2 more weeks.
Spent time, 6-7days.

Many TODOs and REDOs..
- basically no functionality when it comes to comments.
- permalink is gotten but not applied
- REDO to utilize the same context for page browsing to keep the bottom navbar and eliminate possibility for collidision of keys or mem leaks
- The scroll controller together with global keys are underused, as I planned smooth scroll transition.
  - Interesting effect made with the AnimatedContainers height property, but I deemed it inefficient as it recalculated Layout and and yielded an unwanted 'push down' of posts during top directional scroll.
  - Ended up using the Matrix property to only manipulate pixels and hitboxes during scroll animation at a threshold.
- Chose to save post Ids for navigation as reddits 'count' was at the time a pain to get to work as it gave a correct 'before' only once and the next query returned null.
- No cleanup or comments in code.
- Videos just show the thumbnail.
- Galleries are not displayed.
- Empty selftext still displays widget padding.

I would love finish the project if I can be given a bit more time, or redo the test on a different platform in a shorter time span. Which ever fits better.

All the best to you!
