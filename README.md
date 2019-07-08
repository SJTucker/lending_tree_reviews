# lending_tree_reviews

## examples 
  `http://localhost:3000/api/reviews?url=https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183` - will return 15 results as default limit

  `http://localhost:3000/api/reviews?url=https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183&limit=0` - will all results, but will take a while as I didn't have time to implement caching or writing to file :|


added a response limit and introduced bug - still need to fix
