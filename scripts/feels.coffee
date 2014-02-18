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
  robot.hear /I feel (.*)$/i, (msg) ->
    howeyness = msg.match[1]
    feeler = msg.message.user.name.split(' ')[0].toLowerCase()
    peeps[feeler] = howeyness

  robot.respond /(how's|how is|how does|how do) (\w+) feel(?:ing)?$/i, (msg) ->
    feeler = msg.match[2].toLowerCase()
    if feeler == 'i'
      feeler = msg.message.user.name.split(' ')[0].toLowerCase()
    if feeler == 'robot' || feeler == 'otterbot'
      msg.reply "Just like a robot should."
    if peeps[feeler]
      if msg.match[2].toLowerCase() == 'i'
        addressee = 'you'
      else
        addressee = msg.match[2]
      msg.reply "Last I heard, #{addressee} felt #{peeps[feeler]}"
