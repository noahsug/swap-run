{EntityFactory} = require "../coffee/entity_factory.coffee"
{EventEmitter} = require "../coffee/event_emitter.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{util} = require "../coffee/util.coffee"

exports.EnemySpawner = class EnemySpawner extends EventEmitter

  constructor: ->
    super()
    @setSpawnRequests []

  setSpawnRequests: (@spawnRequests_) ->
    @spawnRequestIndex_ = 0
    @elapsed_ = 0
    @spawning_ = []

  isDoneSpawningEnemies: ->
    @spawnRequests_.length is @spawnRequestIndex_

  update: (dt) ->
    @elapsed_ += dt
    @addNewSpawnRequests_()
    @spawnEnemies_()

  addNewSpawnRequests_: ->
    spawnRequest = @spawnRequests_[@spawnRequestIndex_]
    while spawnRequest?.time < @elapsed_
      @handleSpawnRequest_ spawnRequest
      @spawnRequestIndex_++
      spawnRequest = @spawnRequests_[@spawnRequestIndex_]

  handleSpawnRequest_: (spawnRequest) ->
    if spawnRequest.spawnImmediately
      for i in [1..spawnRequest.spawnImmediately.quantity]
        @spawn_ spawnRequest.spawnImmediately.type
    @setCurrentlySpawning_ spawnRequest

  setCurrentlySpawning_: (spawnRequest) ->
    @spawning_ = spawnRequest.spawn ? []
    for spawnInfo in @spawning_
      spawnInfo.spawnTime = spawnRequest.time

  spawnEnemies_: ->
    for spawnInfo in @spawning_
      while spawnInfo.spawnTime < @elapsed_
        @spawn_ spawnInfo.type
        spawnInfo.spawnTime += spawnInfo.rate

  spawn_: (type) ->
    enemy = EntityFactory.create type
    enemyPos = @getRandomBorderPos_ enemy.getRadius()
    enemy.setPos enemyPos
    @emit "spawn", enemy

  getRandomBorderPos_: (radius) ->
    spawnOnTopOrBottom = util.flipCoin()
    spawnOnTopOrLeft = util.flipCoin()

    randomizedDimension = if spawnOnTopOrBottom then atom.width else atom.height
    staticDimension = if spawnOnTopOrBottom then atom.height else atom.width
    coord1 = if spawnOnTopOrLeft then -radius else staticDimension + radius
    coord2 = Math.random() * (randomizedDimension + 2 * radius) - radius

    if spawnOnTopOrBottom
      { x: coord2, y: coord1 }
    else
      { x: coord1, y: coord2 }
