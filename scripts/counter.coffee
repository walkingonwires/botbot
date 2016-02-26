# Description:
#   This script allows hubot to count whenever you ++ or -- something, for example:
#      coffee++
#      coffee: 1
#
# Commands:
#   hubot get count <item> - get the current count of <item> you can increment with item++ and decrement with item--
#   hubot reset count <item> - resets the full count of <item> to 0
#   hubot log daily score for <item> - logs the current count for <item> if it is a high score
#   hubot get high score <item> - shows the current high score for <item>
#
# Author:
#   Jeremy Brown <jeremy@tenfourty.com>
#   modified by Mike Parks <parks.jr@gmail.com>

module.exports = (robot) ->

  robot.hear /(\w+)\+\+/i, (res) ->
    key = res.match[1].trim().toLowerCase()
    value = robot.brain.get(calculateKey(key)) ? 0
    value += 1
    robot.brain.set(calculateKey(key), value)
    res.send "#{key}: #{value}"

  robot.hear /(\w+)--/i, (res) ->
    key = res.match[1].trim().toLowerCase()
    value = robot.brain.get(calculateKey(key)) ? 0
    value -= 1
    robot.brain.set(calculateKey(key), value)
    res.send "#{key}: #{value}"

  robot.respond /get count (.*)/i, (res) ->
    key = res.match[1].trim().toLowerCase()
    value = robot.brain.get(calculateKey(key)) ? 0
    res.send "#{key}: #{value}"

  robot.respond /reset count (.*)/i, (res) ->
    key = res.match[1].trim().toLowerCase()
    value = robot.brain.get(calculateKey(key))
    if value
      robot.brain.set(calculateKey(key), 0)
      res.send "#{key}: 0"
    else
      res.send "There is no count for #{key}"

  robot.respond /(?:get )?high score (.*)/i, (res) ->
    key = res.match[1].trim().toLowerCase()
    value = robot.brain.get(dailyScoreKey(key)) ? 'n/a'
    res.send "High score for #{key}: #{value}"

  robot.respond /log (?:daily )?score(?: for|\:)? (.*)/i, (res) ->
    key = res.match[1].trim().toLowerCase()
    value = robot.brain.get(calculateKey(key))
    if value
      highscore = robot.brain.get(dailyScoreKey(key)) ? 0
      if value > highscore
        robot.brain.set(dailyScoreKey(key), value)
        res.send "New High Score for #{key} - #{value}! Old high score was #{highscore}"
      else
        res.send "Today's score for #{key} is #{value}. The current high score is #{highscore}."
    else
      res.send "There is no count for #{key}"


  # Description: returns keys
  #  Params:
  #   recordType: (channel|user)
  #   recordName: channel_name or user_name
  #   weekNum: 0-52
  #
  calculateKey = (key) ->
    "count:#{key}"
  dailyScoreKey = (key) ->
    "countdaily:#{key}"