{util} = require "../coffee/util.coffee"

exports.MoveBehavior = class MoveBehavior
  constructor: (@movingEntity_) ->
    @velocityVector_ = { x: 0, y: 0 }

  getVelocityVector: ->
    @determineVelocityVector_()
    @normalizeVelocityVector_()
    @velocityVector_

  determineVelocityVector_: ->

  normalizeVelocityVector_: ->
    if @velocityVector_.x == @velocityVector_.y == 0 then return
    slope = Math.abs(@velocityVector_.y / @velocityVector_.x)
    if slope is Infinity
      @velocityVector_.y = util.sign @velocityVector_.y
    else
      xVelocity = 1 / Math.sqrt(1 + Math.pow(slope, 2))
      @velocityVector_.x = xVelocity * util.sign @velocityVector_.x
      @velocityVector_.y = slope * xVelocity * util.sign @velocityVector_.y
