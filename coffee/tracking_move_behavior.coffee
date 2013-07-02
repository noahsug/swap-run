{MoveBehavior} = require "../coffee/move_behavior.coffee"

exports.TrackingMoveBehavior = class TrackingMoveBehavior extends MoveBehavior

  determineVelocityVector_: ->
    @velocityVector_.x = @velocityVector_.y = 0
    target = @knowledge_.getPlayer()
    return unless target and target.isActive()
    @velocityVector_.x = target.getPos().x - @movingEntity_.getPos().x
    @velocityVector_.y = target.getPos().y - @movingEntity_.getPos().y
