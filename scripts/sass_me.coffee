# Description:
#   Get sassy.
#
# Commands:
#   hubot sass me <three word phrase / or / three phrases> - Get some sass
#

module.exports = (robot) ->
  robot.respond /sass me (.*)$/i, (msg) ->
    query = msg.match[1]
    sassy_phrase = query.split(/\s+\/\s+/)
    if sassy_phrase.length > 3
      msg.send("Listen bub I got no more than three things to say / get it / right")
    else
      if sassy_phrase.length == 1
        words = sassy_phrase[0].split(/\s+/)
        if words.length <= 3
          sassy_phrase = words
      sassy_phrase.reverse()[2] ||= ""
      sassy_phrase = sassy_phrase.reverse()
      output = """
```
(•_•)
<) )╯   #{sassy_phrase[0] || ""}
 / \\

 (•_•)
\\( (>   #{sassy_phrase[1] || ""}
 / \\

(•_•)
<) )╯   #{sassy_phrase[2] || ""} 
 / \\
```
"""
      msg.send(output)