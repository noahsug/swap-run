{EventEmitter} = require "../coffee/event_emitter.coffee"
{EntityFactory} = require "../coffee/entity_factory.coffee"

exports.EnemySpawner = class EnemySpawner extends EventEmitter

  constructor: ->
    super()
    @spawnTime_ = 1
    @timeUntilSpawn_ = 0

  update: (dt) ->
    @timeUntilSpawn_ -= dt
    while @timeUntilSpawn_ <= 0
      @spawn_()
      @timeUntilSpawn_ += @spawnTime_

  spawn_: ->
    enemy = EntityFactory.create "enemy"
    @emit "spawn", enemy
