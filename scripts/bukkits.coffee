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
  robot.respond /bukkit$/i, (msg) ->
   robot.http("http://bukkit.tangentialism.com")
    .get() (err, res, body) ->
      msg.send res.headers.location

