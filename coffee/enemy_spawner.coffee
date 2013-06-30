{EntityFactory} = require "../coffee/entity_factory.coffee"
{EventEmitter} = require "../coffee/event_emitter.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{util} = require "../coffee/util.coffee"

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
    type = util.randElement ['enemy', 'bat', 'ogre', 'spectre', 'deathknight',
        'skeleton']
    type = 'bat'
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
