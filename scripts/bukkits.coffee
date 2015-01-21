# Description:
#   Fetches a serendipitous image from Ethan Marcotte's legendary bukk.it, possibly matching your choice of word.
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect: "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot bukkit (.*)
#
# Author:
#   David Yee (@tangentialism)
#


htmlparser = require "htmlparser"
Select     = require("soupselect").select

# If false, you must address your robot directly.
ROBOT_IS_REALLY_ATTENTIVE = true

module.exports = (robot) ->
  bukkit_bucket = []

  sources = {
    'bukkit': 'http://bukk.it/',
    'misatkes': 'http://misatkes.com/',
    'wilto': 'http://wil.to/_/',
    'ryan': 'http://ryan.is/gifs/',
    'floops': 'http://floops.io/',
    'giflimo': 'http://gif.limo/'
  }

  bukkits = (source_bukkit) ->
    if bukkit_bucket.length == 0
      for own key, source of sources
        fill_bukkit(key, source)
    
    if source_bukkit
      return bukkit_bucket.filter (x) -> x[1] == source_bukkit
    else
      return bukkit_bucket

  bukkits_that_look_like = (word, source_bukkit) ->
    reggie = new RegExp(word, "i");

    if source_bukkit
      return bukkits().filter (x) -> x[0].match(reggie) && x[1] == source_bukkit
    else
      return bukkits().filter (x) -> x[0].match(reggie)

  fill_bukkit = (key, source) ->
    robot.http(source)
      .get() (err, res, body) ->
        handler = new htmlparser.DefaultHandler()
        parser = new htmlparser.Parser(handler)
        parser.parseComplete(body)
        bukkitz_elementz = Select handler.dom, "a"
        bukkit_bucket = bukkit_bucket.concat([link.attribs.href, key] for link in bukkitz_elementz when link.attribs.href.match(/^[^\?\/]/))

  giffize_url = (result) ->
    return "#{sources[result[1]]}#{result[0]}"

  fetch_me_a_bukkit = (msg, all) ->
    if msg.match[1]
      source = msg.match[2] if msg.match[2]
      # Let's look for something... *special*
      term = msg.match[1].replace(/\s+/, '')
      my_bukkit = msg.random bukkits_that_look_like(term, source)
      if my_bukkit
        msg.send giffize_url(my_bukkit)
      else
        msg.reply "There is a curious void in the #{source || 'bukk.itz'} for “#{term}”"
    else
      my_bukkit = msg.random bukkits(source)
      msg.send giffize_url(my_bukkit)

  # Start it up.
  bukkits()

  if ROBOT_IS_REALLY_ATTENTIVE
    robot.hear /^bukkit( [\w\-]+)?(?: from (\w+))?$/i, (msg) ->
      fetch_me_a_bukkit(msg)
  else
    robot.respond /bukkit( [\w\-]+)?(?: from (\w+))?$/i, (msg) ->
      fetch_me_a_bukkit(msg)

  robot.respond /reload bukkits/i, (msg) ->
    bukkit_bucket = []
    bukkits()
    msg.reply "All thy bukkits have been reloaded."
