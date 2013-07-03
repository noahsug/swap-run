{Entity} = require "../coffee/entity.coffee"
{Factory} = require "../coffee/factory.coffee"
{Player} = require "../coffee/player.coffee"
{EntitySpriteFactory} = require "../coffee/entity_sprite_factory.coffee"
{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"

exports.EntityFactory = class EntityFactory extends Factory
  @create = (type) -> Factory.create this, type

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
      entity.setRadius 14
      entity.setSpeed 150
      entity.setReactionTime 0
      entity

    "bat": ->
      entity = @createBasicEnemy_()
      entity.setRadius 15
      entity.setSpeed 200
      entity.setReactionTime .5754
      entity

    "ogre": ->
      entity = @createBasicEnemy_()
      entity.setRadius 21
      entity.setSpeed 75
      entity.setReactionTime .7754
      entity

    "skeleton": ->
      entity = @createBasicEnemy_()
      entity.setRadius 16
      entity.setSpeed 100
      entity.setReactionTime .6754
      entity

    "deathknight": ->
      entity = @createBasicEnemy_()
      entity.setRadius 18
      entity.setSpeed 140
      entity.setReactionTime .4754
      entity

    "spectre": ->
      entity = @createBasicEnemy_()
      entity.setRadius 16
      entity.setSpeed 225
      entity.setReactionTime .1754
      entity

  createBasicEnemy_: ->
    entity = new Entity(@type_)
    entity.setMoveBehavior new TrackingMoveBehavior
    entity.setGraphic EntitySpriteFactory.create @type_
    entity
