# lending_tree_reviews

## examples 
  `http://localhost:3000/api/reviews?url=https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183` - will return 15 results as default limit

  `http://localhost:3000/api/reviews?url=https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183&limit=0` - will all results, but will take a while as I didn't have time to implement caching or writing to file :|


## summary
Originally, I started the challenge writing the scraper in Python because I thought it was the best tool for the job, and I wanted to serve the response with a Rails api.  I thought this would reflect what you guys might do in the real world (left this up to show the work I did).  I ended up going with an all Rails solution because I thought that was more practical for this challenge, as I'm not super experienced in Python and realized I had never written tests in Python and was wasting time.  I think my ideal solution would involve scheduling a chron or sidekiq job to regularly scrape reviews for all companies and save it to the db with python, and serve up those records with rails.
