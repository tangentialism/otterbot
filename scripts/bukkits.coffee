# Description:
#   gets random bukkit
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect: "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot bukkit
#
# Author:
#   David Yee
#

htmlparser = require "htmlparser"
Select     = require("soupselect").select

module.exports = (robot) ->
  bukkit_bucket = []

  bukkits = () ->
    if bukkit_bucket.length == 0
      robot.http("http://bukk.it/")
          .get() (err, res, body) ->
            handler = new htmlparser.DefaultHandler()
            parser = new htmlparser.Parser(handler)
            parser.parseComplete(body)
            bukkitz_elementz = Select handler.dom, "tr td a"
            bukkit_bucket = (link.attribs.href for link in bukkitz_elementz)
            return bukkit_bucket
    else
      return bukkit_bucket

  bukkits_that_look_like = (word) ->
    reggie = new RegExp(word, "i");
    return bukkits().filter (x) -> x.match(reggie)

  bukkits()

  robot.respond /bukkit( \w+)?$/i, (msg) ->
    if msg.match[1]
      # Let's look for something... *special*
      term = msg.match[1].replace(/\s+/, '')
      my_bukkit = msg.random bukkits_that_look_like(term)
      if my_bukkit
        msg.send "http://bukk.it/#{my_bukkit}"
      else
        msg.reply "There is a curious void in the bukk.it for “#{term}”"
    else
      my_bukkit = msg.random bukkits()
      msg.send "http://bukk.it/#{my_bukkit}"
      


          