{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"
{Entity} = require "../coffee/entity.coffee"
{jasmine_env} = require "../spec/jasmine_env.coffee"

describe "Tracking move behavior", ->
  movement = target = tracker = undefined

  beforeEach ->
    jasmine_env.init this
    movement = new TrackingMoveBehavior()
    tracker = new Entity
    target = new Entity
    movement.setMovingEntity tracker
    movement.setKnowledge getPlayer: -> target

  it "moves right if the target is to the right", ->
    tracker.setPos x: 3, y: 2
    target.setPos x: 10, y: 2
    expect(movement.getVelocityVector()).toEqual x: 1, y: 0

  it "moves up if the target is to the north", ->
    tracker.setPos x: 0, y: 0
    target.setPos x: 0, y: 1
    expect(movement.getVelocityVector()).toEqual x: 0, y: 1

  it "can move diagonally to the target", ->
    tracker.setPos x: 0, y: 0
    target.setPos x: 1, y: 2
    result = movement.getVelocityVector()
    expect(result.x).toAlmostBe .44
    expect(result.y).toAlmostBe .89

  it "can move diagonally to a far away target", ->
    tracker.setPos x: -4, y: 7
    target.setPos x: 32, y: -48
    result = movement.getVelocityVector()
    expect(result.x).toAlmostBe .54
    expect(result.y).toAlmostBe -.83

  it "doesn't move when its reached the target", ->
    expect(movement.getVelocityVector()).toEqual x: 0, y: 0

  it "doesn't move when it has no target", ->
    movement.setKnowledge getPlayer: -> null
    expect(movement.getVelocityVector()).toEqual x: 0, y: 0
