{Entity} = require "../coffee/entity.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{Position} = require "../coffee/position.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"
{util} = require "../coffee/util.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"

describe "An entity", ->
  entity = undefined
  atom.width = 100
  atom.height = 150

  beforeEach ->
    jasmine_env.init this

    entity = new Entity
    entity.setPos x: atom.width / 2, y: atom.height / 2
    entity.setRadius 2
    entity.setSpeed 1
    entity.setMoveBehavior_ new UserInputMoveBehavior

  it "can have its position set", ->
    expect(entity.getPos()).toEqual x: 50, y: 75
    newPos = { x: 8, y: 10 }
    entity.setPos newPos
    expect(entity.getPos()).toEqual newPos

  it "can move left", ->
    atom.input.press 'left'
    entity.update 1
    expect(entity.getPos()).toEqual x: 49, y: 75

  it "can move right", ->
    atom.input.press 'right'
    entity.update 1
    expect(entity.getPos()).toEqual x: 51, y: 75

  it "can move up", ->
    atom.input.press 'up'
    entity.update 1
    expect(entity.getPos()).toEqual x: 50, y: 74

  it "can move down", ->
    atom.input.press 'down'
    entity.update 1
    expect(entity.getPos()).toEqual x: 50, y: 76

  it "can move left, up, right and then down to return to its original position", ->
    origPosition = entity.getPos()
    atom.input.press 'left'
    entity.update 1
    atom.input.release 'left'
    atom.input.press 'up'
    entity.update 1
    atom.input.release 'up'
    atom.input.press 'right'
    entity.update 1
    atom.input.release 'right'
    atom.input.press 'down'
    entity.update 1
    expect(entity.getPos()).toEqual origPosition

  it "moves farther when more time has passed since the last update", ->
    atom.input.press 'down'
    entity.update 10
    expect(entity.getPos()).toEqual x: 50, y: 85

  it "can move diagonally", ->
    atom.input.press 'up'
    atom.input.press 'left'
    entity.update 1
    expect(entity.getPos().x).toBeBetween 49, 50
    expect(entity.getPos().y).toBeBetween 74, 75

  it "moves the same speed when moving diagonally", ->
    origPosition = entity.getPos()
    atom.input.press 'down'
    atom.input.press 'right'
    entity.update 20
    distance = util.distance origPosition, entity.getPos()
    expect(distance).toBe 20
