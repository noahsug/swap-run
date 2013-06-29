{UserInputMoveBehavior} = require "../coffee/user_input_move_behavior.coffee"
{atom} = require "../spec/mock/atom_mock.coffee"

describe "User input move behavior", ->
  movement = undefined

  beforeEach ->
    atom.input.reset()
    movement = new UserInputMoveBehavior()

  tick = ->
    movement.getVelocityVector()

  it "moves left when left is pressed", ->
    atom.input.press 'left'
    expect(movement.getVelocityVector()).toEqual x: -1, y: 0

  it "moves up when up is held down", ->
    atom.input.press 'up'
    tick()
    atom.input.hold 'up'
    expect(movement.getVelocityVector()).toEqual x: 0, y: -1

  it "moves diagonally when right and up are pressed", ->
    atom.input.press 'up'
    atom.input.press 'right'
    expect(movement.getVelocityVector()).toEqual x: 1/Math.SQRT2, y: -1/Math.SQRT2

  it "stops moves diagonally when one direction is released", ->
    atom.input.press 'up'
    atom.input.press 'right'
    tick()
    atom.input.release 'right'
    expect(movement.getVelocityVector()).toEqual x: 0, y: -1
    tick()
    expect(movement.getVelocityVector()).toEqual x: 0, y: -1

  it "initially isn't moving", ->
    expect(movement.getVelocityVector()).toEqual x: 0, y: 0

  it "keeps moving right when right input is released", ->
    atom.input.press 'right'
    tick()
    atom.input.release 'right'
    expect(movement.getVelocityVector()).toEqual x: 1, y: 0

  it "keeps moving diagonally when there is a single update between button releases", ->
    atom.input.press 'right'
    atom.input.press 'down'
    tick()
    atom.input.release 'right'
    tick()
    atom.input.release 'down'
    expect(movement.getVelocityVector()).toEqual x: 1/Math.SQRT2, y: 1/Math.SQRT2
