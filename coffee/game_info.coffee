{util} = require "../coffee/util.coffee"

exports.GameInfo = class GameInfo
  constructor: ->
    @init_()

  init_: ->
    @enemies_ = []
    @state_ = 'starting level'
    @score_ = 0

  reset: ->
    @init_()

  setLevel: (@level_) ->
  getLevel: -> @level_

  setState: (@state_) ->
  getState: -> @state_

  getScore: -> @score_
  setScore: (@score_) ->

  addScore: (amount) ->
    @score_ += amount

  setPlayer: (@player_) ->
  getPlayer: -> @player_

  setEnemies: (@enemies_) ->
  getEnemies: -> @enemies_

  addEnemy: (enemy) ->
    @enemies_.push enemy

  getEntities: ->
    if @player_
      [@player_, @enemies_...]
    else
      @enemies_

  getNearestEnemyTo: (pos) ->
    maxDistanceSquared = Infinity
    nearestEnemy = null
    for enemy in @getEnemies()
      distanceSquared = util.distanceSquared enemy.getPos(), pos
      if distanceSquared < maxDistanceSquared
        maxDistanceSquared = distanceSquared
        nearestEnemy = enemy
    nearestEnemy

  getActiveEnemies: ->
    (e for e in @enemies_ when e.isActive())

  getCollidedEntities: ->
    entities = @getEntities()
    collided = []
    for i in [0..entities.length-2] by 1
      entity1 = entities[i]
      for j in [i+1..entities.length-1] by 1
        entity2 = entities[j]
        if @entitiesCollide_ entity1, entity2
          collided[i] = entity1
          collided[j] = entity2
    (e for e in collided when e?)

  entitiesCollide_: (entity1, entity2) ->
    distance = util.distance entity1.getPos(), entity2.getPos()
    distance < entity1.getRadius() + entity2.getRadius()
