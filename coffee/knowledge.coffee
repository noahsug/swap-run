exports.Knowledge = class Knowledge
  constructor: (@game_) ->

  getPlayer: ->
    @game_.getPlayer()

  getNearestEnemy: (entity) ->
    # TODO actually return nearest enemy
    @game_.getEnemies()[0]
