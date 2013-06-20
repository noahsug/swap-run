{Entity} = require "../coffee/entity.coffee"
{TrackingMoveBehavior} = require "../coffee/tracking_move_behavior.coffee"

exports.Enemy = class Enemy extends Entity

  constructor: (type) ->
    super type
    @setMoveBehavior_ new TrackingMoveBehavior()
    @moveBehavior_.setTracker this

  setTarget: (target) ->
    @moveBehavior_.setTarget target
