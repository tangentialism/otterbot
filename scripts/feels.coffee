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

module.exports = (robot) ->
  robot.hear /I (?:am )?feel(?:ing)? (.*)$/i, (msg) ->
    howeyness = msg.match[1]
    user = robot.brain.userForId(msg.envelope.user.id)
    user.feels = howeyness

  robot.respond /(how's|how is|how does|how do) (\w+) feel(?:ing)?$/i, (msg) ->
    feeler = msg.match[2].toLowerCase()
    if feeler == "everybody" || feeler == "everyone"
      console.log("shoulda been a contender")
    else if feeler == 'i'
      feeler = msg.message.user
    else if feeler == 'robot' || feeler == 'otterbot'
      msg.reply "Just like a robot should."
    else
      users = robot.brain.usersForFuzzyName(feeler)
      if users.length > 0
        feeler = users[0]
      else
        msg.reply "I sense a curious lack of feeling from #{feeler}."

    if msg.match[2].toLowerCase() == 'i'
      addressee = 'you'
    else
      addressee = msg.match[2]

    if robot.brain.data.users[feeler.id]['feels']
      da_feels = robot.brain.data.users[feeler.id].feels
      msg.reply "Last I heard, #{addressee} felt #{da_feels}"
    else
      msg.reply "I sense only a curious lack of feeling from #{addressee}."

  robot.respond /(how's|how is|how does|how do) every(?:body|one) feel/i, (msg) ->
    users = for id,user of (robot.brain.data.users or { })
      user

    if users.length > 0
      for user in users
        if user.feels
          msg.send "#{user.name} was feeling #{user.feels}"
    else
      msg.reply "Nobody feels anything, really. It's a total absence of feels."
