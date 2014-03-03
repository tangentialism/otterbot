# Description:
#   gets random bukkit
#
# Dependencies:
#   None
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
module.exports = (robot) ->
  robot.respond /bukkit( \w+)?$/i, (msg) ->
   bukkit_url = "http://bukkit.tangentialism.com"
   if msg.match[1]
     term = msg.match[1].replace(/\s+/, '')
     bukkit_url += "/#{term}"
   robot.http(bukkit_url)
    .get() (err, res, body) ->
      msg.send res.headers.location

