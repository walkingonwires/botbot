# Description:
#   Custom Actions
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot clear - clears the window with large empty block
#
# Author:
#   Andrew

module.exports = (robot) ->
  robot.respond /CLEAR$/i, (msg) ->
    msg.send "``` \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ```"
