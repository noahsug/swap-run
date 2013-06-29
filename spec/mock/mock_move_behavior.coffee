{MoveBehavior} = require "../../coffee/move_behavior.coffee"

exports.MockMoveBehavior = class MockMoveBehavior extends MoveBehavior
  constructor: ->
    super()
    @directions_ = []

  move: (@directions_...) ->

  stop: ->
    @directions_ = []

  determineVelocityVector_: ->
    @velocityVector_.y = @velocityVector_.x = 0
    if 'left' in @directions_
      @velocityVector_.x -= 1
    if 'right' in @directions_
      @velocityVector_.x += 1
    if 'up' in @directions_
      @velocityVector_.y -= 1
    if 'down' in @directions_
      @velocityVector_.y += 1
