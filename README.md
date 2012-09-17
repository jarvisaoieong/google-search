# Google-Search

Google Search client

## Installation

    npm install google-search

## Usage

    google(query, [page], fn)

```javascript
var google = require('google');

var nextCounter = 0;

google('node.js', function(err, results){
  if (err) {
    console.error(err);
    return;
  } 
  // ... your logic here
});

google('node.js', 2, function(err, results){
  if (err) {
    console.error(err);
    return;
  } 
  // ... your logic here
});
```

The results json format

```json
{
  "count": 1000,
  "data": [
    {
      "title": "How To Node - NodeJS",
      "url": "http:\/\/howtonode.org\/",
      "description": "howtonode.org\/ - Cached - SimilarCommunity supported blog, teaches about the various tasks and fundamental   concepts to write effective code."
    },
    ...
  ]
}
```

## License
 
The MIT License