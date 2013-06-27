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
    @renderer_ = new Renderer
    @gameInfo_ = new GameInfo
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
    @renderer_.draw @gameInfo_

  resize: ->
    @draw()

  update: (dt) ->
    switch @gameInfo_.getState()
      when 'playing' then @updatePlaying_ dt
      when 'lost' then @updateEndGame_()

  updateEndGame_: ->
    if atom.input.down 'swap'
      @restart_()

  updatePlaying_: (dt) ->
    @spawner_.update dt
    @updateEntities_ dt
    @checkCollisions_()
    @removeInactive_()
    @checkGameOver_()

  updateEntities_: (dt) ->
    # Update player last so swapped enemies go to player's last location.
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
      @gameInfo_.setState 'lost'
