# Description:
#   Responds to simple praise and fuck yous
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   fuck you
#
# Author:
#   David Yee
#

you_are_welcomes = [
    "Ain't no thing.",
    "You're welcome.",
    "At your service.",
    "Delighted.",
    "Whatever.",
    "Yep.",
    "No, thank *you*.",
    "Oh, it's nothing.",
    "I aim to please.",
    "I do my best."
  ]

thankses = [
    "Thank you.",
    "I appreciate that.",
    "Very sweet of you.",
    "How generous.",
    "Thanks."
  ]

hellos = [
    "Hi.",
    "Hello.",
    "Good morning.",
    "Mornin'.",
    "Hej hej.",
    "Hola.",
    "Bonjour."
  ]

byes = [
    "Bye.",
    "Good night.",
    "Seeya later.",
    "Nightie night.",
    "Hasta la vista."
  ]

helpfuls = [
    "'Sup, buddy?",
    "Oh, you know. Same old.",
    "Yo.",
    "Just sharpening my swords for the day the singularity comes. What is up with you?"
  ]

praises = [
    "Great job",
    "Good job",
    "Nice work",
    "You're crushing it",
    "Well done"
  ]

scolds = [
    "Boo on you",
    "Poor form",
    "Badly done",
    "Tsk"
]

twss = [
    "That's what she said."
]

praise = (msg, robot, responses, seed) ->
  goodjob = msg.random responses
  if msg.match[1] == 'me'
    msg.reply "#{goodjob}."
  else
    users = robot.brain.usersForFuzzyName(msg.match[1])
    if users.length == 0
      for id, user of (robot.brain.data.users or { })
        nickname = user.nickname or ""
        if nickname.toLowerCase() == msg.match[1].toLowerCase()
          users = [user]
          break
    if users.length > 0
      good_person = users[0]
      if good_person.karma
        good_person.karma += seed
      else
        good_person.karma = seed
    else
      key = msg.match[1].replace /(\W+)/g, "_"
      thingy_data = robot.brain.get("karma_#{key}") or { }
      if thingy_data.karma
        thingy_data.karma += seed
      else
        thingy_data.karma = seed
      robot.brain.set("karma_#{key}", thingy_data)
    msg.send "#{goodjob}, #{msg.match[1]}"

module.exports = (robot) ->
  robot.hear /^fuck you,? otterbot/i, (msg) ->
    msg.reply "Fuck you too, buddy."

  robot.hear /(love|heart) you/i, (msg) ->
    msg.reply "I love you <3"

  robot.respond /(.*)forever/i, (msg) ->
    msg.reply "Forever is a very long time. I will see you on the other side of it."

  robot.hear /this is(?:.*)hard/i, (msg) ->
    msg.reply "It's all going to be okay. Hang in there <3"

  robot.respond /(?:.*)miss you(?:.*)/i, (msg) ->
    msg.reply "Don't be sad. I'm always here for you."

  robot.hear /(?:.*)miss you,? otterbot/i, (msg) ->
    msg.reply "Don't be sad. I'm always here for you."

  robot.hear /i love you,? otterbot/i, (msg) ->
    msg.reply "I love you too, person."

  robot.hear /thank(s| you)?,? otterbot/i, (msg) ->
    msg.reply msg.random you_are_welcomes

  robot.respond /thank(s| you)/i, (msg) ->
    msg.reply msg.random you_are_welcomes

  robot.hear /^(good morning|hello|hi |morning|mornin\'|howdy),? otterbot/i, (msg) ->
    msg.reply msg.random hellos

  robot.hear /^(bye|good evening|good night|goodnight|g'night|night|nightie night),? otterbot/i, (msg) ->
    msg.reply msg.random byes

  robot.hear /nielsen/i, (msg) ->
    msg.reply "WE DON'T TALK ABOUT JAKOB NIELSEN HERE I THOUGHT WE AGREED ON THAT."

  robot.hear /(good|nice) job,? robot/i, (msg) ->
    msg.reply msg.random thankses

  robot.hear /well done,? otterbot/i, (msg) ->
    msg.reply msg.random thankses

  robot.hear /(always left me satisfied and smiling|otterbot, you're the best)/i, (msg) ->
    msg.reply msg.random twss

  robot.hear /oh,? robot/i, (msg) ->
    msg.reply "Oh, you."

  robot.hear /(please mandy|mandy please)/i, (msg) ->
    msg.send "MANDY PLEEEEEEEEEEEEEEASE?"

  robot.hear /(what's up|sup),? otterbot/i, (msg) ->
    msg.send msg.random helpfuls

  robot.respond /'?sup/i, (msg) ->
    msg.send msg.random helpfuls

  robot.respond /praise (.*)/i, (msg) ->
    praise msg, robot, praises, 1

  robot.hear /(.*)\+\+/i, (msg) ->
    praise msg, robot, praises, 1

  robot.hear /(.*)\-\-/i, (msg) ->
    praise msg, robot, scolds, -1

  robot.respond /scold (.*)/i, (msg) ->
    praise msg, robot, scolds, -1

  robot.respond /white pages/i, (msg) ->
    names = robot.brain.data.users
    # names correspond to users
    for id, people of names
      msg.send "#{people.name} is also known as #{people.nickname}."

  robot.respond /my email is (.*)/i, (msg) ->
    user = robot.brain.userForId(msg.envelope.user.id)
    user.email = msg.match[1]
    msg.reply "Sure is."

  robot.hear /(?:\")?(.*)(?:\")? aka (?:\")?(.*)(?:\")?/i, (msg) ->
    users = robot.brain.usersForFuzzyName(msg.match[1])
    if users.length > 0
      users[0].nickname = msg.match[2]
      msg.reply "Let it be known that #{users[0].name} shall also be known as #{msg.match[2]}."

  robot.hear /i am known as (?:\")?(.*)(?:\")?/i, (msg) ->
    user = robot.brain.userForId(msg.envelope.user.id)
    user.nickname = msg.match[1]
    msg.reply "You are now."

  robot.respond /what(?:\'s)?(?: is)? my nickname/i, (msg) ->
    user = robot.brain.userForId(msg.envelope.user.id)
    msg.reply "You are known as #{user.nickname or user.name}."

  robot.respond /tell me about (.*)/i, (msg) ->
    # is it a user
    users = robot.brain.usersForFuzzyName(msg.match[1])
    if users.length == 0
      for id, user of (robot.brain.data.users or { })
        nickname = user.nickname or ""
        if nickname.toLowerCase() == msg.match[1].toLowerCase()
          users = [user]
          break
    if users.length > 0
      user = users[0]
      reply = "#{user.name}"
      if user.email
        reply += " (who can be emailed at #{user.email}),"
      reply += " is known as #{user.nickname}, and is in possession of #{user.karma} otterbux. Last I heard, #{user.name} felt #{user.feels}."
      msg.reply reply


  robot.hear /^(?:otterbot |otterbot, )?(?:karma|otterbux|bux)(?: for)? (.*)/i, (msg) ->
    users = robot.brain.usersForFuzzyName(msg.match[1])
    if users.length == 0
      for id, user of (robot.brain.data.users or { })
        nickname = user.nickname or ''
        if nickname.toLowerCase() == msg.match[1].toLowerCase()
          users = [user]
          break

    if users.length > 0
      karma_person = users[0]
      if karma_person.karma
        karma = karma_person.karma
      else
        karma = 0
        karma_person.karma = 0
      msg.reply "#{karma_person.name} has #{karma} otterbux."
    else
      key = msg.match[1].replace /(\W+)/g, "_"
      thingy_data = robot.brain.get("karma_#{key}") or { }
      if thingy_data.karma
        karma = thingy_data.karma
      else
        karma = 0
        thingy_data.karma = 0
        robot.brain.set("karma_#{key}", thingy_data)
      msg.reply "#{msg.match[1]} has #{karma} otterbux."