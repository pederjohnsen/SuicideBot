###
# SuicideBot
# Kills itself completely when told to suicide
# 2015 (c) Peder Johnsen <me@pederjohnsen.com>
###
irc = require 'irc'
_   = require 'underscore'
rm  = require 'rimraf'

# Triggers array
triggersArray = [
    'die'
    'pussy'
    'wimp'
    'suicide'
    'kill yourself'
    'kill your self'
]

# Suicide types
suicideTypes = [
    'hangs himself'
    'shoots himself'
    'jumps off a cliff'
    'jumps infront of a train'
    'jumps off a bridge'
    'drowns himself'
    'blows himself up'
]

data = {}
data.appFolder = process.cwd()

suicidebot = new irc.Client 'irc.server', 'SuicideBot',
    userName: 'SuicideBot'
    realName: 'SuicideBot'
    channels: [
        '#channel'
    ]

suicidebot.addListener 'message', (from, to, message) ->
    # Get rid of any extra whitespace in the message
    data.message = message.trim()
    if data.message.toLowerCase().indexOf('suicidebot') is 0
        # Split message on the first whitespace
        data.message = data.message.split /\s(.*)/g

        # Check if the message sent to SuicideBot is within the triggersArray
        if data.message[1] in triggersArray
            console.log 'SuicideBot is going to kill himself! :O'
            suicidebot.say to, "#{from} :("
            # Completely delete SuicideBot
            rm data.appFolder, (err) ->
                if err
                    suicidebot.say to, "#{from}, I failed to kill myself :("
                else
                    suicidebot.action to, "#{suicideTypes[_.random(suicideTypes.length-1)]}"
                    suicidebot.disconnect 'dead'
        else
            suicidebot.say to, "#{from}, I just wants to die :("
