# Description:
#   Keeps track of how you are feeling
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot I feel sexy
#   hubot How is David
#
# Author:
#   David Yee
#

peeps = {}

module.exports = (robot) ->
  robot.hear /I feel (like)?(.*)$/i, (msg) ->
    likeness = msg.match[1]
    howeyness = msg.match[2]
    if likeness != 'like'
      feeler = msg.message.user.name.split(' ')[0].toLowerCase()
      peeps[feeler] = howeyness

  robot.respond /(how's|how is|how does) (\w+) feel(?:ing)?$/i, (msg) ->
    feeler = msg.match[2].toLowerCase()
    if peeps[feeler]
      msg.reply "Last I heard, #{msg.match[2]} felt #{peeps[feeler]}"
