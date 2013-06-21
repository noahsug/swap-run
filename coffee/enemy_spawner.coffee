{EntityFactory} = require "../coffee/entity_factory.coffee"
{EventEmitter} = require "../coffee/event_emitter.coffee"

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
    enemy.setPos x: 5, y: 5
    @emit "spawn", enemy
