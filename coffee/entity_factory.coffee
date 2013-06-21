{Entity} = require "../coffee/entity.coffee"
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
    entity = new Entity(@type_)
    entity.setRadius 14
    entity.setSpeed 200
    entity.setMoveBehavior_ new UserInputMoveBehavior
    entity

  createEnemy: ->
    entity = new Entity(@type_)
    entity.setRadius 16
    entity.setSpeed 150
    entity.setMoveBehavior_ new TrackingMoveBehavior
    entity
