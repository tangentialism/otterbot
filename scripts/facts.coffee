# Description:
#   Stores and regurgitates useless information
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   FACT: blah blah blah
#
# Author:
#   David Yee
#

acks = [
    "You don't say.",
    "Ah, so noted.",
    "Huh!",
    "That's crazy.",
    "I did not, in fact, know that.",
    "Wow!",
    "That is really interesting.",
    "I could see that, yeah.",
    "You are so smart!"
  ]

module.exports = (robot) ->
  robot.hear /^FACT: (.*)/i, (msg) ->
    facts = robot.brain.get("facts") or [ ]
    facts.push msg.match[1]
    robot.brain.set("facts", facts)
    msg.reply msg.random acks

  robot.respond /fact\?/i, (msg) ->
    facts = robot.brain.get("facts") or [ ]
    fact = msg.random facts
    msg.send "FACT: #{fact}"
