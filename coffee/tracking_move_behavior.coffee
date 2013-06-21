{MoveBehavior} = require "../coffee/move_behavior.coffee"

exports.TrackingMoveBehavior = class TrackingMoveBehavior extends MoveBehavior

  determineVelocityVector_: ->
    target = @knowledge_.getPlayer()
    return unless target
    @velocityVector_.x = target.getPos().x - @movingEntity_.getPos().x
    @velocityVector_.y = target.getPos().y - @movingEntity_.getPos().y
