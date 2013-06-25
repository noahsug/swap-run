{Entity} = require "../coffee/entity.coffee"
{Player} = require "../coffee/player.coffee"
{SpriteFactory} = require "../coffee/sprite_factory.coffee"
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
      entity.setGraphic SpriteFactory.create @type_
      entity

    "enemy": ->
      entity = new Entity(@type_)
      entity.setRadius 16
      entity.setSpeed 150
      entity.setMoveBehavior new TrackingMoveBehavior
      entity.setGraphic SpriteFactory.create @type_
      entity
