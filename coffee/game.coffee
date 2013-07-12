{EntityFactory} = require "../coffee/entity_factory.coffee"
{GameInfo} = require "../coffee/game_info.coffee"
{LevelFactory} = require "../coffee/level_factory.coffee"
{Renderer} = require "../coffee/renderer.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{keybindings} = require "../coffee/keybindings.coffee"
{util} = require "../coffee/util.coffee"

exports.Game = class Game extends atom.Game
  constructor: ->
    super
    atom.setDesiredSurfaceArea 500000
    keybindings.configure()
    @maxTimeDifference_ = .075
    @gameInfo_ = new GameInfo
    @renderer_ = new Renderer @gameInfo_
    @init_()

  init_: ->
    @gameInfo_.reset()
    @initPlayer_()
    @startLevelIntro_ 1

  initPlayer_: ->
    player = EntityFactory.create "player"
    player.setKnowledge @gameInfo_
    @gameInfo_.setPlayer player

  startLevelIntro_: (num) ->
    @gameInfo_.getLevel()?.end()
    if num > LevelFactory.LAST_LEVEL
      @gameInfo_.setState 'beat game'
    else
      @gameInfo_.setState 'level intro'
      @gameInfo_.setLevel LevelFactory.createLevel num
      @gameInfo_.getLevel().on 'spawn', (enemy) =>
        @addEnemy_ enemy

  addEnemy_: (enemy) ->
    @gameInfo_.addEnemy enemy
    enemy.setKnowledge @gameInfo_

  restart_: ->
    @init_()
    @startPlaying_()

  startPlaying_: ->
    @renderer_.reset()
    @gameInfo_.setEnemies []
    @gameInfo_.getPlayer().setPos { x: atom.width / 2, y: atom.height / 2 }
    @gameInfo_.getPlayer().reset()
    @gameInfo_.setState 'playing'

  draw: ->
    @renderer_.draw()

  resize: ->
    @draw()

  update: (dt) ->
    dt = Math.min dt, @maxTimeDifference_
    @checkPause_()
    @renderer_.update dt
    switch @gameInfo_.getState()
      when 'level intro' then @updateStartingLevel_ dt
      when 'playing' then @updatePlaying_ dt
      when 'paused' then 'do nothing'
      when 'lost' then @updateLost_ dt
      when 'beat game' then @updateBeatGame_()

  checkPause_: ->
    if atom.input.pressed 'pause'
      if @gameInfo_.getState() is 'paused'
        @gameInfo_.setState 'playing'
      else if @gameInfo_.getState() is 'playing'
        @gameInfo_.setState 'paused'

  updateStartingLevel_: (dt) ->
    if atom.input.pressed 'swap'
      @startPlaying_()

  updateBeatGame_: ->
    if atom.input.pressed 'swap'
      @restart_()

  updatePlaying_: (dt) ->
    @gameInfo_.getLevel().update dt
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
      if entity.getType() isnt 'player'
        @renderer_.drawEntityDeath entity

  removeInactive_: ->
    prevNumEnemies = @gameInfo_.getEnemies().length
    activeEnemies = @gameInfo_.getActiveEnemies()
    @gameInfo_.setEnemies activeEnemies
    @gameInfo_.addScore prevNumEnemies - activeEnemies.length

  checkGameOver_: ->
    if not @gameInfo_.getPlayer().isActive()
      @gameInfo_.setState 'lost'
    else if @gameInfo_.getLevel().isFinished()
      @startNextLevelIntro_()

  startNextLevelIntro_: ->
    @startLevelIntro_ @gameInfo_.getLevel().getNumber() + 1

  updateLost_: (dt) ->
    @updateEntities_ dt
    if @renderer_.lostAnimationFinished() and atom.input.pressed 'swap'
      @restart_()
