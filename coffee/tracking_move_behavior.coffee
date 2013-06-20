{MoveBehavior} = require "../coffee/move_behavior.coffee"

exports.TrackingMoveBehavior = class TrackingMoveBehavior extends MoveBehavior

  setTracker: (@tracker_) ->

  setTarget: (@target_) ->

  determineVelocityVector_: ->
    return unless @target_ and @tracker_
    @velocityVector_.x = @target_.getPos().x - @tracker_.getPos().x
    @velocityVector_.y = @target_.getPos().y - @tracker_.getPos().y
