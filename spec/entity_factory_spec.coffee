{EntityFactory} = require "../coffee/entity_factory.coffee"
{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"

describe "An entity factory", ->

  beforeEach ->
    jasmine_env.init this

  it "can create a player", ->
    entity = EntityFactory.create "player"
    expect(entity.getType()).toBe "player"
    expect(entity.moveBehavior_).toBeAnInstanceOf UserInputMoveBehavior

  it "can create an enemy", ->
    entity = EntityFactory.create "enemy"
    expect(entity.getType()).toBe "enemy"
    expect(entity.moveBehavior_).toBeAnInstanceOf TrackingMoveBehavior

  it "can create an wide array of enemies", ->
    types = ['enemy', 'bat', 'ogre', 'deathknight', 'skeleton']
    for type in types
      entity = EntityFactory.create type
      expect(entity.getType()).toBe type

  it "throws an error when creating an unsupported entity type", ->
    failingFunction = -> EntityFactory.create "not supported"
    expect(failingFunction).toThrow()
