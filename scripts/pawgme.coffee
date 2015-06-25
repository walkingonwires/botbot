# Description:
#   Pawgme.... it's kind of a big deal
#
# Dependencies:
#   None
#
# Configuration:
#   PAWG_CHANNEL_RESTRICTION - (optional) restrics pawgs to specified channel
#
# Commands:
#   hubot pawg me - Receive a pawg
#   hubot pawg bomb N - get N pawgs
#
# Author:
#   Mike Parks - parks.jr@gmail.com
_channelRestriction = process.env.PAWG_CHANNEL_RESTRICTION
baseurl = "http://pawgme.herokuapp.com"
randomurl = baseurl + "/random"
counturl = baseurl + "/count"
bomburl = baseurl + "/bomb?count="

module.exports = (robot) ->

  robot.respond /pawg me/i, (msg) ->
    if allClear(msg)
      msg.http(randomurl)
        .get() (err, res, body) ->
          msg.send JSON.parse(body).url

  robot.respond /pawg bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    if allClear(msg)
      msg.http(bomburl + count)
        .get() (err, res, body) ->
          pawgs = JSON.parse body
          for pawg in pawgs
            msg.send pawg.url

  robot.respond /how many pawgs are there/i, (msg) ->
    msg.http(counturl)
      .get() (err, res, body) ->
        msg.send "There are #{body} pawgs."

allClear = (msg) ->
  doit = isRoom(msg.message.room)
  pic = msg.random srslybro
  msg.send nsfwMessage(pic) unless doit
  return doit

isRoom = (currRoom) ->
  return !_channelRestriction? || currRoom == _channelRestriction

nsfwMessage = (randbro) ->
  "....that belongs in ##{_channelRestriction}, bro...\n#{randbro}"

srslybro = [
    'http://cutecaptions.com/images/he-was-getting-irritated-that-i-wa/dude-what-are-you-doing.jpg',
    'http://cdn.meme.am/instances/45929815.jpg',
    'http://1.bp.blogspot.com/-J-2ePN1z9p4/UCEQTQ8ckcI/AAAAAAAAC8M/JPvpo-h9nd0/s1600/Dude+what+are+you+doing.jpg',
    'http://4.bp.blogspot.com/-849fjLKI9Lg/Tzgnf6LTGoI/AAAAAAAAAKo/MgjUuMBge7M/s1600/seriouslybro.png',
    'http://cdn.meme.am/instances/500x/13736071.jpg',
    'https://daditsok.files.wordpress.com/2013/05/bro-what-the-fuck-is-wrong-with-you.jpg',
    'https://creepyorcool.files.wordpress.com/2014/05/seriously-bro.jpg',
    'http://treasure.diylol.com/uploads/post/image/564616/thumb_dwight-schrute-meme-generator-seriously-bro-clean-up-86749a.jpg',
    'http://www.quickmeme.com/img/d6/d6e0ecbc0b8b198e4797b0a92d3738c9b35a5c7c098731990e8ad00548d16d07.jpg',
    'http://1.bp.blogspot.com/-HRAAwfbBMrE/VHkTFLu-hVI/AAAAAAAAI28/IvH1GqTxDUw/s1600/lolcat-are-you-serious-bro.jpg'
]
