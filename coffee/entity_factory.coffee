{Entity} = require "../coffee/entity.coffee"
{Player} = require "../coffee/player.coffee"
{EntitySpriteFactory} = require "../coffee/entity_sprite_factory.coffee"
{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"

exports.EntityFactory = class EntityFactory
  @instance_ = new EntityFactory

  @create = (type) ->
    @instance_.create type

  create: (@type_) ->
    if @type_ of @creationMethods_
      @creationMethods_[@type_].apply(this)
    else
      throw "entity of type '#{@type_}' was not found"

  creationMethods_:
    "player": ->
      entity = new Player(@type_)
      entity.setRadius 14
      entity.setSpeed 200
      entity.setMoveBehavior new UserInputMoveBehavior
      entity.setGraphic EntitySpriteFactory.create @type_
      entity

    "enemy": ->
      entity = @createBasicEnemy_()
      entity.setRadius 16
      entity.setSpeed 150
      entity.setReactionTime .3754
      entity

    "bat": ->
      entity = @createBasicEnemy_()
      entity.setRadius 16
      entity.setSpeed 200
      entity.setReactionTime .5754
      entity

  createBasicEnemy_: ->
    entity = new Entity(@type_)
    entity.setMoveBehavior new TrackingMoveBehavior
    entity.setGraphic EntitySpriteFactory.create @type_
    entity
