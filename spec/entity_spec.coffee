{Entity} = require "../coffee/entity.coffee"
{MoveBehavior} = require "../coffee/move_behavior.coffee"
{Position} = require "../coffee/position.coffee"
{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"
{util} = require "../coffee/util.coffee"

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
    entity.setMoveBehavior new UserInputMoveBehavior

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

  it "doesn't move when no move behavior is specified", ->
    entity.moveBehavior_ = null
    origPos = entity.getPos()
    entity.update 1
    expect(entity.getPos()).toEqual origPos

  it "reports its direction is left when moving left", ->
    atom.input.press 'left'
    entity.update 1
    expect(entity.getDirection()).toBe 'left'

  it "reports its direction is down when moving down", ->
    atom.input.press 'down'
    entity.update 1
    expect(entity.getDirection()).toBe 'down'

  it "reports its direction is right when moving diagonally up and right", ->
    atom.input.press 'up'
    atom.input.press 'right'
    entity.update 1
    expect(entity.getDirection()).toBe 'right'

  it "reports its direction is down when no movement has happened yet", ->
    expect(entity.getDirection()).toBe 'down'

  it "reports its direction is the last reported direction when it stops", ->
    atom.input.press 'up'
    entity.update 1
    atom.input.release 'up'
    entity.update 1
    expect(entity.getDirection()).toBe 'up'

  it "reports that its moving when moving", ->
    atom.input.press 'up'
    entity.update 1
    expect(entity.isMoving()).toBe true

  it "reports that its not moving when it stops moving", ->
    atom.input.press 'up'
    entity.update 1
    expect(entity.isMoving()).toBe true
    atom.input.release 'up'
    entity.update 1
    expect(entity.isMoving()).toBe false

  it "reports that its not moving when it has never moved", ->
    expect(entity.isMoving()).toBe false
