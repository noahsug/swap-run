{EntityFactory} = require "../coffee/entity_factory.coffee"
{EnemySpawner} = require "../coffee/enemy_spawner.coffee"
{GameInfo} = require "../coffee/game_info.coffee"
{Renderer} = require "../coffee/renderer.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{keybindings} = require "../coffee/keybindings.coffee"
{util} = require "../coffee/util.coffee"

exports.Game = class Game extends atom.Game
  constructor: ->
    super
    keybindings.configure()
    @gameInfo_ = new GameInfo
    @renderer_ = new Renderer @gameInfo_
    @init_()

  init_: ->
    @gameInfo_.reset()
    @initPlayer_()
    @initEnemySpawner_()

  initPlayer_: ->
    player = EntityFactory.create "player"
    player.setKnowledge @gameInfo_
    player.setPos { x: atom.width / 2, y: atom.height / 2 }
    @gameInfo_.setPlayer player

  initEnemySpawner_: ->
    @spawner_ = new EnemySpawner()
    @spawner_.on 'spawn', (enemy) =>
      @addEnemy_ enemy

  addEnemy_: (enemy) ->
    @gameInfo_.addEnemy enemy
    enemy.setKnowledge @gameInfo_

  restart_: ->
    @init_()

  draw: ->
    @renderer_.draw()

  resize: ->
    @draw()

  update: (dt) ->
    @listenToKeyboardShortcuts_()
    @renderer_.update dt
    switch @gameInfo_.getState()
      when 'paused' then 'do nothing'
      when 'playing' then @updatePlaying_ dt
      when 'dying' then @updateDying_ dt
      when 'lost' then @updateEndGame_()

  listenToKeyboardShortcuts_: ->
    if atom.input.pressed 'pause'
      if @gameInfo_.getState() is 'paused'
        @gameInfo_.setState @unpauseState_
      else
        @unpauseState_ = @gameInfo_.getState()
        @gameInfo_.setState 'paused'

  updatePlaying_: (dt) ->
    @spawner_.update dt
    @updateEntities_ dt
    @checkCollisions_()
    @removeInactive_()
    @checkGameOver_()

  updateEntities_: (dt) ->
    # Update player last so swapped enemies go to player's previous location.
    for enemy in @gameInfo_.getEnemies()
      enemy.update dt
    @gameInfo_.getPlayer().update dt

  checkCollisions_: ->
    for entity in @gameInfo_.getCollidedEntities()
      entity.die()

  removeInactive_: ->
    prevNumEnemies = @gameInfo_.getEnemies().length
    activeEnemies = @gameInfo_.getActiveEnemies()
    @gameInfo_.setEnemies activeEnemies
    @gameInfo_.addScore prevNumEnemies - activeEnemies.length

  checkGameOver_: ->
    unless @gameInfo_.getPlayer().isActive()
      @gameInfo_.setState 'dying'

  updateDying_: (dt) ->
    @updateEntities_ dt
    if @renderer_.deathAnimationFinished()
      @gameInfo_.setState 'lost'

  updateEndGame_: ->
    if atom.input.down 'swap'
      @restart_()
