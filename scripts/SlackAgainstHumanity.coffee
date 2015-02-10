    # Description:
    #   Cards Against Humanity!
    #
    # Dependencies:
    #   None
    #
    # Commands:
    #   hubot cards deal - adds you to the current cards game
    #   hubot cards quit - removes you from the current cards game
    #   hubot cards show - messages you your cards again incase you forgot
    #   /cards {id} - plays the id of your chosen card for the current round (a slack slash command is taking care of it though)
    #   hubot cards choose {id} - The current round's judge chooses the best card against the pre determined black card
    #
    # Author:
    #   michael-hopkins
    deal = "http://ec2-52-0-112-141.compute-1.amazonaws.com/cards/deal"
    quit = "http://ec2-52-0-112-141.compute-1.amazonaws.com/cards/quit"
    choose = "http://ec2-52-0-112-141.compute-1.amazonaws.com/cards/choose"
    show = "http://ec2-52-0-112-141.compute-1.amazonaws.com/cards/show"

    module.exports = (hubot) ->
        hubot.respond /cards deal/i, (msg) ->
            user = msg.message.user.name
            message = msg.message.text
            room = msg.message.user.room
            data = {'user_name': user,'message': message,'room': room,'directive': 1}
            hubot.http(deal).query(data).get() (err, res, body) ->

        hubot.respond /cards quit/i, (msg) ->
            user = msg.message.user.name
            message = msg.message.text
            room = msg.message.user.room
            data = {'user_name': user,'message': message,'room': room,'directive': 1}
            hubot.http(quit).query(data).get() (err, res, body) ->

        hubot.respond /cards show/i, (msg) ->
            user = msg.message.user.name
            message = msg.message.text
            room = msg.message.user.room
            data = {'user_name': user,'message': message,'room': room,'directive': 1}
            hubot.http(show).query(data).get() (err, res, body) ->

        hubot.respond /cards choose (.*)/i, (msg) ->
            user = msg.message.user.name
            message = msg.message.text
            room = msg.message.user.room
            cardId = msg.match[1]
            data = {'user_name': user,'message': message,'room': room,'directive': 1,'cardId': cardId}
            hubot.http(choose).query(data).get() (err, res, body) ->
