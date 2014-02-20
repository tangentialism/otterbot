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

module.exports = (robot) ->
  robot.hear /^fuck you,? otterbot/i, (msg) ->
    msg.reply "Fuck you too, buddy."
  
  robot.hear /love you/i, (msg) ->
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
  
  robot.hear /^(bye|good evening|good night|g'night|night|nightie night),? otterbot/i, (msg) ->
    msg.reply msg.random byes
    
  robot.hear /nielsen/i, (msg) ->
    msg.reply "WE DON'T TALK ABOUT JAKOB NIELSEN HERE I THOUGHT WE AGREED ON THAT."
    
  robot.hear /(good|nice) job,? robot/i, (msg) ->
    msg.reply msg.random thankses
  
  robot.hear /well done,? otterbot/i, (msg) ->
    msg.reply msg.random thankses
    
  robot.hear /oh,? robot/i, (msg) ->
    msg.reply "Oh, you."

  robot.hear /(please mandy|mandy please)/i, (msg) ->
    msg.send "MANDY PLEEEEEEEEEEEEEEASE?"
    
  robot.hear /(what's up|sup),? otterbot/i, (msg) ->
    msg.send msg.random helpfuls
  
  robot.respond /'?sup/i, (msg) ->
    msg.send msg.random helpfuls
    
  robot.respond /praise (.*)/i, (msg) ->
    goodjob = msg.random praises
    if msg.match[1] == 'me'
      msg.reply "#{goodjob}."
    else
      users = robot.brain.usersForFuzzyName(msg.match[1])
      if users.length == 0
        for id, user of robot.brain.data.users or { }
          if user.nickname.toLowerCase() == msg.match[1].toLowerCase()
            users = [user]
            break
      if users.length > 0
        good_person = users[0]
        if good_person.karma
          good_person.karma += 1
        else
          good_person.karma = 1
      msg.send "#{goodjob}, #{msg.match[1]}"

  robot.respond /scold (.*)/i, (msg) ->
    goodjob = msg.random scolds
    if msg.match[1] == 'me'
      msg.reply "#{goodjob}."
    else
      users = robot.brain.usersForFuzzyName(msg.match[1])
      if users.length == 0
        for id, user of robot.brain.data.users or { }
          if user.nickname.toLowerCase() == msg.match[1].toLowerCase()
            users = [user]
            break
      if users.length > 0
        bad_person = users[0]
        if good_person.karma
          good_person.karma -= 1
        else
          good_person.karma = -1
      msg.send "#{goodjob}, #{msg.match[1]}"

  robot.respond /white pages/i, (msg) ->
    names = robot.brain.data.users
    # names correspond to users
    for id, people of names
      msg.send "#{people.name} is also known as #{people.nickname}."

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

  robot.respond /karma (.*)/i, (msg) ->
    users = robot.brain.usersForFuzzyName(msg.match[1])
    if users.length == 0
      for id, user of robot.brain.data.users or { }
        if user.nickname.toLowerCase() == msg.match[1].toLowerCase()
          users = [user]
          break

    if users.length > 0
      karma_person = users[0]
      if karma_person.karma
        karma = karma_person.karma
      else
        karma = 0
        karma_person.karma = 0
      msg.reply "#{karma_person.name} has #{karma} karma."