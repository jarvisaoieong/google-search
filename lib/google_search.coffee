request = require 'request'
cheerio = require 'cheerio'
_ = require 'underscore'
util = require 'util'
querystring = require 'querystring'

urlPattern = 'http://www.google.com/search?hl=en&q=%s&start=%s&sa=N';
selector = 
  count: '#resultStats'
  list: 'li.g'
  link: 'h3.r a'
  description: 'div.s'
  next: 'td.b a span'

module.exports = (query, page, fn) ->
  if _.isFunction page
    fn = page
    page = 1

  start = (page - 1) * 10
  url = util.format urlPattern, querystring.escape(query), start

  request url, (err, res, body) ->    
    if err
      fn err
      return

    # Load the html
    $ = cheerio.load body

    # Get the count
    count = $(selector.count)
      .html()
      .replace(/,/g, '')
      .match(/about.*results/ig)[0]
      .match(/\d+/)[0]

    # Get the data
    results = []
    $(selector.list).each (i, el) ->
      # make some cache to optimize performance
      $this = $(this)
      $link = $this.find selector.link
      qsObj = querystring.parse $link.attr 'href'
      results.push 
        title: $link.text()
        url: qsObj['/url?q']
        description: $(this).find(selector.description).text()
      
    fn null, 
      count: parseInt count
      data: results

