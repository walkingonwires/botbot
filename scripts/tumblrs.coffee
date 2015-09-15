# Description:
#   some fun commands using tumblrbot
#
# Dependencies:
#   tumblrbot
#
# Configuration:
#   none
# 
# Commands:
#   hubot crab me - random crabs with cigarettes
# 	hubot hobodesk - random hobo desks
#
# Author:
#   Mike Parks parks.jr@gmail.com

tumblr = require 'tumblrbot'
crabs = "crabswithcigarettes.tumblr.com"
hobodesks = "hobodesks.tumblr.com"

module.exports = (robot) ->
 	robot.respond /crab(?: me)?$/i, (msg) ->
   	tumblr.photos(crabs).random (post) ->
    	msg.send post.photos[0].original_size.url
 	robot.respond /(?:hobo desk|hobodesks|hobo desks|hobodesk)(?: me)?$/i, (msg) ->
 		tumblr.photos(hobodesks).random (post) ->
 			msg.send post.photos[0].original_size.url
