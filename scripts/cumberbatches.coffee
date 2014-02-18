# Description:
#   Constructs random Benedict Cumberbatches
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   benedict
#
# Author:
#   David Yee
#

benedicts = [
    "BENEDICT",
    "BAILIWICK",
    "BORNFREE",
    "BARSTOOLINGTON",
    "BORINGTEDTALK",
    "BRATWURST",
    "BATMITZVAH",
    "BATHYSPHERE",
    "BATTLEMENT",
    "BENTO BOX",
    "BENEVOLENT",
    "BENDYSTRAWS",
    "BUNDYSTRICT",
    "BANDERSNATCH",
    "BEERSANDWICH",
    "BALACLAVA",
    "BALTHAZAR",
    "BALACLAVA",
    "BARCALOUNGER"
    "BARNDOOR"
    "BENELUX"
    "BEERBELLY"
    "BARACKOBAMA"
    "BEECHNUT"
    "BEANCOUNTER"
    "FLORENTINE"
    "PRANAYAMA"
    "BENS-A-DICK"
    "BENEFITS"
    "BRANDYWITCH"
  ]
  
cumberbatches = [
    "CARBUNCLE",
    "COREPOWER",
    "CARBURETOR",
    "CAMBRIANAGE",
    "CUMBERBATCH",
    "CAMISOLE",
    "CAMELBACK",
    "CAMOUFLAGE",
    "CHLOROFORM",
    "CLAM-DIGGERS",
    "CAMEMBERT",
    "CUMMERBUND",
    "MONTALBAN",
    "COMBOBRATS",
    "CULPABILITY",
    "CAMBOZOLA",
    "CHRONOTRIGGER",
    "CLAMBAKE"
    "STACKEXCHANGE"
    "CRUMBLECAKE"
    "DUMBLEDORE"
    "MUMBLESNARK"
  ]
  
module.exports = (robot) ->
  robot.hear /benedict cumberbatch/i, (msg) ->
    benedict = msg.random benedicts
    cumberbatch = msg.random cumberbatches
    msg.send "#{benedict} #{cumberbatch}!"
