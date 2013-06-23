{EntityFactory} = require "../coffee/entity_factory.coffee"
{EnemySpawner} = require "../coffee/enemy_spawner.coffee"
{Knowledge} = require "../coffee/knowledge.coffee"
{Renderer} = require "../coffee/renderer.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{keybindings} = require "../coffee/keybindings.coffee"
{util} = require "../coffee/util.coffee"

exports.Game = class Game extends atom.Game

  constructor: ->
    super
    keybindings.configure()
    @renderer_ = new Renderer()
    @init_()

  init_: ->
    @state_ = 'playing'
    @initKnowledge_()
    @initPlayer_ @knowledge_
    @initEnemySpawner_()
    @score_ = 0

  initKnowledge_: ->
    @knowledge_ = new Knowledge
    @knowledge_.setGameInfo this

  initPlayer_: (knowledge) ->
    @player_ = EntityFactory.create "player"
    @player_.setKnowledge knowledge
    @player_.setPos { x: atom.width / 2, y: atom.height / 2 }

  getPlayer: -> @player_

  initEnemySpawner_: ->
    @enemies_ = []
    @spawner_ = new EnemySpawner()
    @spawner_.on 'spawn', (enemy) =>
      @addEnemy_ enemy

  addEnemy_: (enemy) ->
    enemy.setKnowledge @knowledge_
    @enemies_.push enemy

  getEnemies: -> @enemies_

  getState: -> @state_

  getScore: -> @score_

  update: (dt) ->
    switch @state_
      when 'playing' then @updatePlaying_ dt
      when 'lost' then @updateEndGame_()

  updateEndGame_: ->
    if atom.input.down 'swap'
      @restartGame_()

  updatePlaying_: (dt) ->
    @spawner_.update dt
    @updateEntities_ dt
    @checkCollisions_()
    @removeInactive_()
    @state_ = 'lost' if !@player_.isActive()

  updateEntities_: (dt) ->
    for enemy in @enemies_
      enemy.update dt
    @player_.update dt

  checkCollisions_: ->
    entities = [@enemies_..., @player_]
    for i in [0..entities.length-2] by 1
      entity1 = entities[i]
      for j in [i+1..entities.length-1] by 1
        entity2 = entities[j]
        if @entitiesCollide_ entity1, entity2
          entity1.die()
          entity2.die()

  entitiesCollide_: (entity1, entity2) ->
    distance = util.distance entity1.getPos(), entity2.getPos()
    distance < entity1.getRadius() + entity2.getRadius()

  removeInactive_: ->
    prevNumEnemies = @enemies_.length
    @enemies_ = (e for e in @enemies_ when e.isActive())
    @score_ += prevNumEnemies - @enemies_.length

  restartGame_: ->
    @init_()

  draw: ->
    @renderer_.draw this

  resize: ->
    @draw()
