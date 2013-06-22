{util} = require "../coffee/util.coffee"

exports.Knowledge = class Knowledge

  setGameInfo: (@gameInfo_) ->

  getPlayer: ->
    @gameInfo_.getPlayer()

  getNearestEnemyTo: (pos) ->
    maxDistanceSquared = Infinity
    nearestEnemy = null
    for enemy in @gameInfo_.getEnemies()
      distanceSquared = util.distanceSquared enemy.getPos(), pos
      if distanceSquared < maxDistanceSquared
        maxDistanceSquared = distanceSquared
        nearestEnemy = enemy
    nearestEnemy
