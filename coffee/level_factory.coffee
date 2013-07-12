{EnemySpawner} = require "../coffee/enemy_spawner.coffee"
{EventEmitter} = require "../coffee/event_emitter.coffee"
{Factory} = require "../coffee/factory.coffee"
{Level} = require "../coffee/level.coffee"

exports.LevelFactory = class LevelFactory extends Factory
  @createLevel = (type) -> Factory.create this, type

  @LAST_LEVEL = 2

  constructor: ->
    @enemySpawner_ = new EnemySpawner

  processResult_: (description) ->
    level = new Level
    @enemySpawner_.setSpawnRequests description.spawnRequests
    level.setEnemySpawner @enemySpawner_
    level.setTitle description.title
    level.setNumber @type_
    level

  creationMethods_:
    1: ->
      title: 'The Bat Cave'
      spawnRequests: [
        { time: 0, spawn: [{ type: 'bat', rate: .9 }] },
        { time: 5 } ]
    2: ->
      title: 'zombies'
      spawnRequests: [
        { time: 0, spawnImmediately: { type: 'skeleton', quantity: 10 } },
        { time: 1, spawn: [{ type: 'skeleton', rate: .9 }] },
        { time: 5, spawn: [{ type: 'deathknight', rate: 2 },
            { type: 'skeleton', rate: .9 }] },
        { time: 10, spawn: [{ type: 'deathknight', rate: 2 },
            { type: 'skeleton', rate: .9 }, { type: 'ogre', rate: 2 }] },
        { time: 15 } ]
