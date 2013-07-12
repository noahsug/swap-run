{EventEmitter} = require "../coffee/event_emitter.coffee"

exports.Level = class Level extends EventEmitter
  constructor: ->
    super

  end: ->
    @enemySpawner_.clear 'spawn', @onSpawn_

  setEnemySpawner: (@enemySpawner_) ->
    @enemySpawner_.on 'spawn', @onSpawn_

  onSpawn_: (enemy) =>
    @emit 'spawn', enemy

  setTitle: (@title_) ->
  getTitle: -> @title_

  setNumber: (@number_) ->
  getNumber: -> @number_

  update: (dt) ->
    @enemySpawner_.update dt

  isFinished: ->
    @enemySpawner_.isDoneSpawningEnemies()
