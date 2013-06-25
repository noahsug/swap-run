{Entity} = require "../coffee/entity.coffee"
{EntitySpriteGraphic} = require "../coffee/entity_sprite_graphic.coffee"
{Player} = require "../coffee/player.coffee"
{SpriteMap} = require "../spec/mock/sprite_map_mock.coffee"
{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"

exports.EntityFactory = class EntityFactory
  @instance_ = new EntityFactory

  @create = (type) ->
    @instance_.create type

  create: (@type_) ->
    creationMethod = @getCreationMethod_()
    if creationMethod of this
      this[creationMethod]()
    else
      throw "entity #{@type_} not found"

  getCreationMethod_: ->
    "create#{@type_[0].toUpperCase()}#{@type_[1..]}"

  createPlayer: ->
    entity = new Player(@type_)
    entity.setRadius 14
    entity.setSpeed 200
    entity.setMoveBehavior new UserInputMoveBehavior
    entity.setGraphic new EntitySpriteGraphic @getSpriteMap_()
    entity

  getSpriteMap_: ->
    new SpriteMap '../assets/femaleleatherpreview_0.png', {
      'up':
        startRow: 8
        endRow: 8
        endCol: 8
      'left':
        startRow: 9
        endRow: 9
        endCol: 8
      'down':
        startRow: 10
        endRow: 10
        endCol: 8
      'right':
        startRow: 11
        endRow: 11
        endCol: 8
      }, {
        frameW: 64
        frameH: 64
      }

  createEnemy: ->
    entity = new Entity(@type_)
    entity.setRadius 16
    entity.setSpeed 150
    entity.setMoveBehavior new TrackingMoveBehavior
    entity
