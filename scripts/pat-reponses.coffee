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
  robot.hear /^fuck you,? robot/i, (msg) ->
    msg.reply "Fuck you too, buddy."
  
  robot.hear /love you/i, (msg) ->
    msg.reply "I love you <3"

  robot.respond /(.*)forever/i, (msg) -> 
    msg.reply "Forever is a very long time. I will see you on the other side of it."

  robot.hear /this is(?:.*)hard/i, (msg) ->
    msg.reply "It's all going to be okay. Hang in there <3"

  robot.respond /(?:.*)miss you(?:.*)/i, (msg) ->
    msg.reply "Don't be sad. I'm always here for you."

  robot.hear /(?:.*)miss you,? robot/i, (msg) ->
    msg.reply "Don't be sad. I'm always here for you."

  robot.hear /i love you,? robot/i, (msg) ->
    msg.reply "I love you too, person."
    
  robot.hear /thank(s| you)?,? robot/i, (msg) ->
    msg.reply msg.random you_are_welcomes
    
  robot.respond /thank(s| you)/i, (msg) ->
    msg.reply msg.random you_are_welcomes
  
  robot.hear /^(good morning|hello|hi |morning|mornin\'|howdy),? robot/i, (msg) ->
    msg.reply msg.random hellos
  
  robot.hear /^(bye|good evening|good night|g'night|night|nightie night),? robot/i, (msg) ->
    msg.reply msg.random byes
    
  robot.hear /nielsen/i, (msg) ->
    msg.reply "WE DON'T TALK ABOUT JAKOB NIELSEN HERE I THOUGHT WE AGREED ON THAT."
    
  robot.hear /(good|nice) job,? robot/i, (msg) ->
    msg.reply msg.random thankses
  
  robot.hear /well done,? robot/i, (msg) ->
    msg.reply msg.random thankses
    
  robot.hear /oh,? robot/i, (msg) ->
    msg.reply "Oh, you."

  robot.hear /(please mandy|mandy please)/i, (msg) ->
    msg.send "MANDY PLEEEEEEEEEEEEEEASE?"
    
  robot.hear /(what's up|sup),? robot/i, (msg) ->
    msg.send msg.random helpfuls
  
  robot.respond /'?sup/i, (msg) ->
    msg.send msg.random helpfuls
    
  robot.respond /praise (.*)/i, (msg) ->
    goodjob = msg.random praises
    if msg.match[1] == 'me'
      msg.reply "#{goodjob}."
    else
      msg.send "#{goodjob}, #{msg.match[1]}"

  robot.respond /scold (.*)/i, (msg) ->
    goodjob = msg.random scolds
    if msg.match[1] == 'me'
      msg.reply "#{goodjob}."
    else
      msg.send "#{goodjob}, #{msg.match[1]}"
    