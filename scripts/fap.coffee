# Description:
#   Shows upcoming games for all consoles
#
# Dependencies:
#   None
#
# Configuration:
#   None
# Commands:
#   hubot fap - NSFW random fap pic
#
# Author:
#   Allan Mohr

tumblr = require 'tumblrbot'
FAP = "iwouldfapthat.tumblr.com"

module.exports = (robot) ->
 robot.respond /fap/i, (msg) ->
   tumblr.photos(FAP).random (post) ->
     msg.send post.photos[0].original_size.url
